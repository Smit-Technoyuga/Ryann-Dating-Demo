import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/delete_photos_req/delete_photos_req_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/cubit/add_photo_state.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class AddPhotoCubit extends Cubit<AddPhotoState> {
  AddPhotoCubit() : super(const AddPhotoState());

  final ImagePicker _picker = ImagePicker();
  static const int maxImages = 4;

  void init() {
    final profile = getIt<ProfileCubit>().state.profile;
    if (profile?.profilePicture != null &&
        (profile?.profilePicture?.isNotEmpty ?? false)) {
      final initialImages = profile!.profilePicture!
          .map((url) => PhotoItem(url: url))
          .toList();
      emit(state.copyWith(selectedImages: initialImages));
    }
  }

  Future<void> uploadPhotos(BuildContext context) async {
    final localPhotos = state.selectedImages.where((e) => e.isLocal).toList();
    if (localPhotos.isEmpty) {
      if (state.selectedImages.isNotEmpty) {
        // If all are already network images, just proceed
        await context.push(AppRoutes.photoVerification);
      }
      return;
    }

    emit(state.copyWith(isLoading: true, uploadProgress: 0));

    try {
      final files = <MultipartFile>[];
      for (final item in localPhotos) {
        files.add(await MultipartFile.fromFile(item.file!.path));
      }

      await getIt<AuthServices>()
          .addPhotos(files, (count, total) {
            if (total != -1) {
              emit(state.copyWith(uploadProgress: count / total));
            }
          })
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              // Replace all images with the network URLs from the response
              if (value.data?.photos != null) {
                final netImge = state.selectedImages
                    .where((e) => e.isNetwork)
                    .toList();
                final networkImages =
                    netImge +
                    value.data!.photos!
                        .map((url) => PhotoItem(url: url))
                        .toList();
                emit(
                  state.copyWith(
                    selectedImages: networkImages,
                    isLoading: false,
                    isSuccess: true,
                    uploadProgress: 1,
                  ),
                );
                context.push(AppRoutes.photoVerification);
              } else {
                emit(state.copyWith(isLoading: false));
              }
            },
            onFailed: (value) {
              emit(state.copyWith(isLoading: false, uploadProgress: 0));
            },
          );
    } catch (e) {
      emit(state.copyWith(isLoading: false, uploadProgress: 0));
    }
  }

  Future<void> pickImage() async {
    // Check if already at max capacity
    if (state.selectedImages.length >= maxImages) {
      return;
    }

    // Request permission
    final permissionStatus = await _requestPermission();
    if (!permissionStatus) {
      return;
    }

    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        final imageFile = File(image.path);
        final updatedImages = List<PhotoItem>.from(state.selectedImages)
          ..add(PhotoItem(file: imageFile));
        emit(state.copyWith(selectedImages: updatedImages, errorMessage: ''));
      }
    } catch (e) {
      // Handle error silently or show toast
    }
  }

  Future<bool> _requestPermission() async {
    PermissionStatus status;

    if (Platform.isIOS) {
      status = await Permission.photos.request();
    } else {
      // For Android 13+ (API 33+), use photos permission
      // For older Android versions, use storage permission
      if (await Permission.photos.isGranted ||
          await Permission.storage.isGranted) {
        return true;
      }

      status = await Permission.photos.request();
      if (status.isDenied) {
        status = await Permission.storage.request();
      }
    }

    if (status.isPermanentlyDenied) {
      // Open app settings
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }

  Future<void> removeImage(int index) async {
    if (index >= 0 && index < state.selectedImages.length) {
      final item = state.selectedImages[index];

      if (item.isNetwork) {
        // Call delete API
        try {
          await getIt<AuthServices>()
              .deletePhotos(DeletePhotosReqModel(photoUrls: [item.url!]))
              .handler(
                isLoading: true,
                onSuccess: (value) {
                  final updatedImages = List<PhotoItem>.from(
                    state.selectedImages,
                  )..removeAt(index);
                  emit(
                    state.copyWith(
                      selectedImages: updatedImages,
                      errorMessage: '',
                    ),
                  );
                },
              );
        } catch (e) {
          // Error handled by handler
        }
      } else {
        final updatedImages = List<PhotoItem>.from(state.selectedImages)
          ..removeAt(index);
        emit(state.copyWith(selectedImages: updatedImages, errorMessage: ''));
      }
    }
  }

  bool validateImages(String errorMessage) {
    if (state.selectedImages.isEmpty) {
      emit(state.copyWith(errorMessage: errorMessage));
      return false;
    }
    emit(state.copyWith(errorMessage: ''));
    return true;
  }

  void clearError() {
    if (state.errorMessage != null) {
      emit(state.copyWith(errorMessage: ''));
    }
  }
}
