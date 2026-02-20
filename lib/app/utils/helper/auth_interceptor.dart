import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/refresh_token_req_model/refresh_token_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/refresh_token_res/refresh_token_res_model.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart';
import 'package:ryann_dating/app/routes/app_pages.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/config/app_config.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/extensions/string_ext.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/helper/storage_service.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._storageService, this._authServicesProvider);

  final StorageService _storageService;
  final AuthServices Function() _authServicesProvider;

  Completer<String?>? _refreshTokenCompleter;
  bool _isLoggingOut = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isRefreshTokenRequest = options.path.contains(
      AppConfig.refreshTokenApi,
    );

    if (isRefreshTokenRequest) {
      return super.onRequest(options, handler);
    }

    var token = _storageService.accessToken;

    if (token != null) {
      // Pre-emptive refresh: check if token is expired or about to expire
      if (_isTokenExpired(token)) {
        debugPrint(
          'AuthInterceptor: Token expired pre-emptively, refreshing...',
        );
        final newToken = await _tokenRefreshFlow();
        if (newToken != null) {
          token = newToken;
        }
      }
      options.headers['Authorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if the request is for the refresh-token itself
    final isRefreshTokenRequest = err.requestOptions.path.contains(
      AppConfig.refreshTokenApi,
    );

    if (err.response?.statusCode == 401) {
      // If the refresh token request itself failed with 401, logout immediately
      if (isRefreshTokenRequest) {
        await logout();
        return super.onError(err, handler);
      }

      final refreshToken = _storageService.refreshToken;

      if (refreshToken?.isNotEmpty ?? false) {
        // If a refresh is already in progress, wait for it
        if (_refreshTokenCompleter != null) {
          final newToken = await _refreshTokenCompleter!.future;
          if (newToken != null) {
            // Retry the original request with the new token
            return handler.resolve(await _retry(err.requestOptions, newToken));
          } else {
            // If refresh failed for others, this one should also fail
            return super.onError(err, handler);
          }
        }

        // Start a new refresh process
        _refreshTokenCompleter = Completer<String?>();
        final newToken = await _tokenRefreshFlow();

        if (newToken != null) {
          return handler.resolve(await _retry(err.requestOptions, newToken));
        }
      } else {
        await logout();
      }
    }

    // Special handling for unknown error on multipart requests
    // Server might reset connection on large uploads with expired tokens
    if (err.type == DioExceptionType.unknown ||
        err.type == DioExceptionType.connectionError) {
      if (err.requestOptions.data is FormData) {
        debugPrint(
          'AuthInterceptor: Unknown error on multipart, attempting speculative refresh...',
        );
        final newToken = await _tokenRefreshFlow();
        if (newToken != null) {
          return handler.resolve(await _retry(err.requestOptions, newToken));
        }
      }
      debugPrint(
        'AuthInterceptor: Unknown/Connection error caught: ${err.message}',
      );
      debugPrint('Path: ${err.requestOptions.path}');
    }

    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
    String token,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'Authorization': 'Bearer $token'},
      contentType: requestOptions.contentType,
      extra: requestOptions.extra,
      responseType: requestOptions.responseType,
    );

    // If it's multipart/form-data, Dio might have issues re-sending the same FormData.
    // However, we must try to pass the same data.
    final data = requestOptions.data;

    debugPrint('AuthInterceptor: Retrying request: ${requestOptions.uri}');

    return Dio(BaseOptions(baseUrl: requestOptions.baseUrl)).request<dynamic>(
      requestOptions.uri.toString(), // Use full URI
      data: data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<String?> _tokenRefreshFlow() async {
    // If a refresh is already in progress, wait for it
    if (_refreshTokenCompleter != null) {
      return _refreshTokenCompleter!.future;
    }

    _refreshTokenCompleter = Completer<String?>();

    final refreshToken = _storageService.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      _refreshTokenCompleter?.complete(null);
      _refreshTokenCompleter = null;
      await logout();
      return null;
    }

    try {
      await _authServicesProvider()
          .refreshToken(RefreshTokenReq(refreshToken: refreshToken))
          .handler(
            isLoading: false,
            showToast: false,
            onSuccess: (RefreshTokenRes value) async {
              if ((value.data?.accessToken?.isNotEmpty ?? false) &&
                  (value.data?.refreshToken?.isNotEmpty ?? false)) {
                await _storageService.saveAccessToken(value.data!.accessToken!);
                await _storageService.saveRefreshToken(
                  value.data!.refreshToken!,
                );
                _refreshTokenCompleter?.complete(value.data!.accessToken);
              } else {
                _refreshTokenCompleter?.complete(null);
                await logout();
              }
            },
            onFailed: (value) async {
              _refreshTokenCompleter?.complete(null);
              await logout();
            },
          );

      final newToken = await _refreshTokenCompleter!.future;
      _refreshTokenCompleter = null;
      return newToken;
    } catch (e) {
      _refreshTokenCompleter?.complete(null);
      _refreshTokenCompleter = null;
      await logout();
      return null;
    }
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      // Decode payload
      var output = parts[1].replaceAll('-', '+').replaceAll('_', '/');
      switch (output.length % 4) {
        case 0:
          break;
        case 2:
          output += '==';
        case 3:
          output += '=';
        default:
          throw Exception('Illegal base64url string!');
      }

      final payload = json.decode(utf8.decode(base64Decode(output)));
      final expiry = payload['exp'] as int?;
      if (expiry == null) return false;

      // Add a small buffer (e.g. 10 seconds)
      final expiryDate = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      return expiryDate.isBefore(
        DateTime.now().add(const Duration(seconds: 10)),
      );
    } catch (e) {
      debugPrint('AuthInterceptor: Error parsing JWT: $e');
      return true; // Assume expired if we can't parse it
    }
  }

  Future<void> logout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;

    await _storageService.clearTokens();
    getIt<ProfileCubit>().clearProfile();

    'Connection Timeout'.errorToast;
    AppPages.router.go(AppRoutes.welcome);

    debugPrint('User logged out due to session expiration');

    // Reset logout flag after a delay to allow future sessions
    Future.delayed(const Duration(seconds: 2), () {
      _isLoggingOut = false;
    });
  }
}
