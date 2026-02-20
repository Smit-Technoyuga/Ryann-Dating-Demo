import 'dart:io';

import 'package:equatable/equatable.dart';

class AddPhotoState extends Equatable {
  const AddPhotoState({
    this.selectedImages = const [],
    this.errorMessage,
    this.isLoading = false,
    this.isSuccess = false,
    this.uploadProgress = 0,
  });

  final List<PhotoItem> selectedImages;
  final String? errorMessage;
  final bool isLoading;
  final bool isSuccess;
  final double uploadProgress;

  AddPhotoState copyWith({
    List<PhotoItem>? selectedImages,
    String? errorMessage,
    bool? isLoading,
    bool? isSuccess,
    double? uploadProgress,
  }) {
    return AddPhotoState(
      selectedImages: selectedImages ?? this.selectedImages,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }

  @override
  List<Object?> get props => [
    selectedImages,
    errorMessage,
    isLoading,
    isSuccess,
    uploadProgress,
  ];
}

class PhotoItem extends Equatable {
  const PhotoItem({this.file, this.url});
  final File? file;
  final String? url;

  bool get isNetwork => url != null;
  bool get isLocal => file != null;

  @override
  List<Object?> get props => [file, url];
}
