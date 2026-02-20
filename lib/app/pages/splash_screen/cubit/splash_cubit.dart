import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ryann_dating/app/pages/splash_screen/cubit/splash_state.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/helper/storage_service.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    emit(SplashLoading());

    // 2 second delay
    await Future.delayed(const Duration(seconds: 2));

    final storage = getIt<StorageService>();
    if (storage.accessToken != null && storage.refreshToken != null) {
      emit(SplashAuthenticated());
    } else {
      emit(SplashNavigateToWelcome());
    }
  }
}
