import 'package:equatable/equatable.dart';

class PhotoVerificationState extends Equatable {
  const PhotoVerificationState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  PhotoVerificationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return PhotoVerificationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage];
}
