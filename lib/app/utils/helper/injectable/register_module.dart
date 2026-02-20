import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/utils/helper/auth_interceptor.dart';
import 'package:ryann_dating/app/utils/helper/connectivity_service.dart';
import 'package:ryann_dating/app/utils/helper/network_interceptor.dart';
import 'package:ryann_dating/app/utils/helper/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio getDio(
    ConnectivityService connectivityService,
    StorageService storageService,
  ) {
    final dio = Dio();
    dio.interceptors.add(NetworkInterceptor(connectivityService));
    dio.interceptors.add(
      AuthInterceptor(storageService, () => AuthServices(dio)),
    );
    return dio;
  }

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
