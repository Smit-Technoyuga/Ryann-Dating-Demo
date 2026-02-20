// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ryann_dating/app/data/auth_services/auth_services.dart'
    as _i651;
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart'
    as _i369;
import 'package:ryann_dating/app/utils/helper/connectivity_service.dart'
    as _i594;
import 'package:ryann_dating/app/utils/helper/injectable/register_module.dart'
    as _i228;
import 'package:ryann_dating/app/utils/helper/storage_service.dart' as _i495;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i594.ConnectivityService>(
      () => _i594.ConnectivityService(),
    );
    gh.lazySingleton<_i495.StorageService>(
      () => _i495.StorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.getDio(
        gh<_i594.ConnectivityService>(),
        gh<_i495.StorageService>(),
      ),
    );
    gh.lazySingleton<_i651.AuthServices>(
      () => _i651.AuthServices(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i369.ProfileCubit>(
      () => _i369.ProfileCubit(gh<_i651.AuthServices>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i228.RegisterModule {}
