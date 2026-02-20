import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CurlInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      _printCurlCommand(options);
    }
    super.onRequest(options, handler);
  }

  void _printCurlCommand(RequestOptions options) {
    final components = <String>['curl'];
    components.add('-X ${options.method.toUpperCase()}');

    options.headers.forEach((key, value) {
      if (key != 'content-length') {
        components.add("-H '$key: $value'");
      }
    });

    if (options.data != null) {
      if (options.data is FormData) {
        final formData = options.data as FormData;
        for (final entry in formData.fields) {
          components.add("-F '${entry.key}=${entry.value}'");
        }
        for (final entry in formData.files) {
          components.add("-F '${entry.key}=@${entry.value.filename}'");
        }
      } else if (options.data is Map || options.data is List) {
        final data = json.encode(options.data);
        components.add("-d '$data'");
      } else {
        components.add("-d '${options.data}'");
      }
    }

    components.add("'${options.uri}'");

    debugPrint('CURL command:');
    debugPrint(components.join(' \\\n  '));
  }
}
