import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' as i;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ryann_dating/app/utils/helper/curl_interceptor.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.config.dart';

final getIt = GetIt.instance;

@i.injectableInit
void configuration({required Widget myApp}) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await getIt.init();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      if (kDebugMode) {
        getIt<Dio>().interceptors.add(PrettyDioLogger(requestBody: true));
        getIt<Dio>().interceptors.add(CurlInterceptor());
      }

      runApp(myApp);
    },
    (error, stackTrace) {
      debugPrint('Startup Error: $error');
      debugPrint('Startup StackTrace: $stackTrace');
    },
    zoneSpecification: ZoneSpecification(
      handleUncaughtError:
          (
            Zone zone,
            ZoneDelegate delegate,
            Zone parent,
            Object error,
            StackTrace stackTrace,
          ) {
            debugPrint('Startup Uncaught Error: $error');
            debugPrint('Startup Uncaught StackTrace: $stackTrace');
          },
    ),
  );
}
