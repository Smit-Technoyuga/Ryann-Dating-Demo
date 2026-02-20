import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/cubit/photo_verification_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class PhotoVerificationCubit extends Cubit<PhotoVerificationState> {
  PhotoVerificationCubit() : super(const PhotoVerificationState());

  Future<void> verifyPhotos(BuildContext context) async {
    emit(state.copyWith(isLoading: true));

    try {
      await getIt<AuthServices>().verifyPhotos().handler(
        isLoading: false,
        showToast: true,
        onSuccess: (value) {
          context.go(
            AppRoutes.welcomeIntentionSelection,
            extra: value.data?.intentions,
          );
          emit(state.copyWith(isLoading: false, isSuccess: true));
        },
        onFailed: (value) {
          emit(state.copyWith(isLoading: false));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
