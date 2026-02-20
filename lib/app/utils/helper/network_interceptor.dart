import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ryann_dating/app/utils/helper/connectivity_service.dart';

class NetworkInterceptor extends Interceptor {
  NetworkInterceptor(this._connectivityService) {
    _connectivityService.isOnline.addListener(_onConnectivityChanged);
  }
  final ConnectivityService _connectivityService;
  final Map<RequestOptions, CancelToken> _activeTokens = {};

  void _onConnectivityChanged() {
    debugPrint(
      'NetworkInterceptor: Connectivity changed to ${_connectivityService.isOnline.value}',
    );
    if (!_connectivityService.isOnline.value) {
      debugPrint(
        'NetworkInterceptor: Cancelling ${_activeTokens.length} active requests',
      );
      // Cancel all active requests when offline
      for (final token in _activeTokens.values) {
        token.cancel('Connection lost');
      }
      _activeTokens.clear();
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Dio Request: ${options.path}');
    if (!_connectivityService.isOnline.value) {
      debugPrint(
        'Device is offline according to ConnectivityService, triggering blink and rejecting request',
      );
      _connectivityService.triggerBlink();
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No Internet Connection',
        ),
      );
    }

    // Attach a CancelToken if not already present
    final cancelToken = options.cancelToken ?? CancelToken();
    options.cancelToken = cancelToken;

    _activeTokens[options] = cancelToken;

    cancelToken.whenCancel.then((_) {
      _activeTokens.remove(options);
    });

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _activeTokens.remove(response.requestOptions);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _activeTokens.remove(err.requestOptions);
    super.onError(err, handler);
  }
}
