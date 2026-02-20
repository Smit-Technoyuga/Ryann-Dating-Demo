// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ryann_dating/app/utils/extensions/string_ext.dart';
import 'package:ryann_dating/app/utils/helper/connectivity_service.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/helper/loading.dart';

@immutable
class UserFriendlyError {
  final String title;
  final String description;

  const UserFriendlyError(this.title, this.description);
}

extension DioExceptionX on DioException {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    return type.toUserFriendlyError(
      badResponseDesc: _statusCode(response?.statusCode),
    );
  }

  String _statusCode(int? statusCode) {
    final res = response?.data;
    if (res is Map<String, dynamic>) {
      if (res.containsKey('message')) {
        return '${res['message']}';
      }
    }
    return statusCode?.toString() ?? 'Bad Response';
  }
}

extension DioExceptionTypeX on DioExceptionType {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError({String? badResponseDesc}) {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return const UserFriendlyError(
          'Connection Timeout',
          'Connection Timeout',
        );
      case DioExceptionType.sendTimeout:
        return const UserFriendlyError('Send Timeout', 'Send Timeout');
      case DioExceptionType.receiveTimeout:
        return const UserFriendlyError('Receive Timeout', 'Receive Timeout');
      case DioExceptionType.badCertificate:
        return const UserFriendlyError('Bad Certificate', 'Bad Certificate');
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          'Bad Response',
          badResponseDesc ?? 'Bad Response',
        );
      case DioExceptionType.cancel:
        return const UserFriendlyError(
          'Request Cancelled',
          'Request Cancelled',
        );
      case DioExceptionType.connectionError:
        return const UserFriendlyError('Connection Error', 'Connection Error');
      case DioExceptionType.unknown:
        return const UserFriendlyError('Unknown', 'Unknown');
    }
  }
}

typedef ApiSuccessCallback<T> = void Function(T value);

typedef ApiFailedCallback<T> = void Function(FailedState<T> value);

extension ApiHandlingX<T> on Future<T> {
  /// Must use handler it's a better way to handle request's response api calling
  /// Must use handler it's a better way to handle request's response api calling
  Future<void> handler({
    bool isLoading = true,
    ApiSuccessCallback<T>? onSuccess,
    ApiFailedCallback<T>? onFailed,
    bool showToast = false,
  }) async {
    if (isLoading) Loading.show();

    try {
      final response = await this;
      onSuccess?.call(response);
    } on DioException catch (e) {
      final failedState = FailedState<T>(
        statusCode: e.response?.statusCode ?? 0,
        isRetirable: switch (e.type) {
          DioExceptionType.connectionError ||
          DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        dioError: e,
      );

      onFailed?.call(failedState);
      if ((showToast || e.response?.statusCode == 404) &&
          e.response?.statusCode != 401 &&
          e.type != DioExceptionType.cancel &&
          getIt<ConnectivityService>().isOnline.value) {
        e.response?.statusCode == 404
            ? 'Something went wrong'.errorToast
            : (e.response?.data['message'] as String? ??
                      failedState.error.title)
                  .errorToast;
      }
    } on Exception {
      final failedState = FailedState<T>(
        statusCode: 0,
        isRetirable: false,
        dioError: null,
      );

      onFailed?.call(failedState);
    } finally {
      if (isLoading) Loading.dismiss();
    }
  }
}

sealed class ApiState<T> {
  static ApiState<T> initial<T>() => InitialState<T>();
}

class SuccessState<T> extends ApiState<T> {
  T value;
  SuccessState(this.value);
}

class InitialState<T> extends ApiState<T> {}

class LoadingState<T> extends ApiState<T> {}

class FailedState<T> extends ApiState<T> {
  bool isRetirable;
  UserFriendlyError get error =>
      dioError?.toUserFriendlyError() ??
      const UserFriendlyError('Api Error', 'Api Error Description');

  Response<T>? get response {
    if (dioError?.response is Response<T>) {
      return dioError!.response! as Response<T>;
    }
    return null;
  }

  DioException? dioError;

  int statusCode;

  FailedState({
    required this.isRetirable,
    required this.statusCode,
    required this.dioError,
  });

  // void showToast() {
  //   Get.showSnackbar(
  //     GetSnackBar(
  //       title: error.title,
  //       message:
  //           (dioError?.response?.data['message'] as String?) ??
  //           error.description,
  //     ),
  //   );
  // }
}
