import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/send_otp_model/send_otp_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/verify_otp_req_model/verify_otp_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/waiting_list_req/waiting_list_req.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/country_city_model/country_city_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_otp_res/verify_otp_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_state.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_cubit.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/string_ext.dart';
import 'package:ryann_dating/app/utils/helper/cancellable_cubit.dart';
import 'package:ryann_dating/app/utils/helper/countries_list.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/helper/loading.dart';
import 'package:ryann_dating/app/utils/helper/storage_service.dart';
import 'package:ryann_dating/app/widgets/sucess_dialog.dart';

class AuthCubit extends Cubit<AuthState> with CancellableCubit<AuthState> {
  AuthCubit({bool isRegister = false})
    : super(
        AuthState(
          countries: const [],
          cityController: TextEditingController(),
          countryController: TextEditingController(),
          emailController: TextEditingController(),
          nameController: TextEditingController(),
          phoneController: TextEditingController(
            text: kDebugMode ? '987654321' : '',
          ),
          otpController: TextEditingController(
            text: kDebugMode ? '123456' : '',
          ),
          searchController: TextEditingController(),
          phoneCountry: countryCodes.firstWhere((e) => e.dialCode == '+61'),
          focusNode: FocusNode(),
          isRegister: isRegister,
        ),
      );

  final controller = RefreshController();

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void selectCountry(Country country) {
    if (country == state.selectedCountry) return;

    emit(
      state.copyWith(
        selectedCountry: country,
        countryController: TextEditingController(text: country.name),
        cityController: TextEditingController(),
        clearSelectedCity: true,
        nameController: TextEditingController(),
        emailController: TextEditingController(),
      ),
    );
  }

  void setIsRegister({required bool value}) {
    emit(state.copyWith(isRegister: value));
  }

  void selectPhoneCountry(CountryCode country) {
    if (country.name == state.selectedCountry?.name) return;

    emit(state.copyWith(phoneCountry: country));
  }

  void selectCity(Country city) {
    emit(
      state.copyWith(
        selectedCity: city,
        cityController: TextEditingController(text: city.name),
        emailController: TextEditingController(),
        nameController: TextEditingController(),
      ),
    );
  }

  // Add other methods as needed
  // void updateOtherField(YourType value) {
  //   emit(state.copyWith(otherField1: value));
  // }

  // Validation method
  String? validateSelection() {
    // Check if country is selected
    final hasCities = state.selectedCountry?.cities?.isNotEmpty ?? false;

    // If country has cities but no city is selected
    if ((hasCities && state.selectedCity == null) || state.countries.isEmpty) {
      return 'Please select a city';
    }

    // Validation passed
    return null;
  }

  // Method to check if can proceed
  bool canProceed() {
    return validateSelection() != null;
  }

  void navigation(BuildContext context) {
    if (state.selectedCountry?.launchStatus == .LIVE &&
        state.selectedCity?.launchStatus == .LIVE) {
      context.push(AppRoutes.registerPhone, extra: this);
    } else {
      context.push(AppRoutes.register, extra: this);
    }
  }

  /// get country list API
  Future<void> getCountryList() async {
    emit(state.copyWith(isLoading: true));
    try {
      await getIt<AuthServices>()
          .getCountries(cancelToken: cancelToken)
          .handler(
            isLoading: false,
            onSuccess: (value) {
              if (!isClosed) {
                emit(
                  state.copyWith(
                    countries: value.data,
                    isLoading: false,
                    defaultCountry: value.data?.firstOrNull,
                    selectedCountry: value.data?.firstOrNull,
                  ),
                );
              }
            },
            onFailed: (value) {
              if (!isClosed) emit(state.copyWith(isLoading: false));
            },
          );
    } catch (e) {
      if (!isClosed) emit(state.copyWith(isLoading: false));
    }
  }

  /// check waiting list API
  Future<void> checkWaitingList(BuildContext context) async {
    emit(state.copyWith(isWaitLoad: true));
    try {
      await getIt<AuthServices>()
          .checkWaitingList(
            WaitingListReq(
              name: state.nameController.text,
              email: state.emailController.text,
              country: state.selectedCountry?.name,
              city: state.selectedCity?.name ?? state.cityController.text,
              countryStatus: state.selectedCountry?.launchStatus?.name,
              cityStatus:
                  state.selectedCity?.launchStatus?.name ??
                  CityStatus.WAITLIST.name,
              countryCode: state.selectedCountry?.countryCode,
              isoCode: state.selectedCountry?.isoCode,
            ),
            cancelToken: cancelToken,
          )
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              if (!isClosed) emit(state.copyWith(isWaitLoad: false));
              if (value.data?.allowNext ?? false) {
                context.push(
                  AppRoutes.registerPhone,
                  extra: context.read<AuthCubit>(),
                );
                if (!isClosed) emit(state.copyWith(userId: value.data?.userId));
              } else {
                showSucessDialog(
                  context,
                  title: context.l10n.youAreOnTheList,
                  subTitle: context.l10n.thanksForRegistering,
                  btnText: context.l10n.gotIt,
                  onTap: () => context.go(AppRoutes.welcome),
                );
              }
            },
            onFailed: (value) {
              if (!isClosed) emit(state.copyWith(isWaitLoad: false));
            },
          );
    } catch (e) {
      if (!isClosed) emit(state.copyWith(isWaitLoad: false));
    }
  }

  /// send otp API
  Future<void> sendOtp(BuildContext context, {bool isResend = false}) async {
    emit(state.copyWith(isSendOtpLoad: !isResend, isReSendOtpLoad: isResend));
    if (isResend) {
      Loading.show();
    }
    try {
      await getIt<AuthServices>()
          .sendOtp(
            SendOtpModel(
              type: state.isRegister ? 1 : 2,
              phoneNumber: state.phoneController.text,
              countryCode: state.phoneCountry?.dialCode,
              isoCode: state.phoneCountry?.countryCode,
            ),
            cancelToken: cancelToken,
          )
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              if (!isClosed) {
                emit(
                  state.copyWith(isSendOtpLoad: false, isReSendOtpLoad: false),
                );
              }
              value.message.successToast;
              if (!isResend) {
                context.push(
                  AppRoutes.otpScreen,
                  extra: context.read<AuthCubit>(),
                );
              } else {
                context.read<OtpTimerCubit>().startTime(isRestart: true);
              }
            },
            onFailed: (value) {
              if (!isClosed) {
                emit(
                  state.copyWith(isSendOtpLoad: false, isReSendOtpLoad: false),
                );
              }
            },
          );
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(isSendOtpLoad: false, isReSendOtpLoad: false));
      }
    } finally {
      Loading.dismiss();
    }
  }

  /// verify otp API
  Future<void> verifyOtp(BuildContext context) async {
    emit(state.copyWith(isVerifyOtpLoad: true));
    try {
      await getIt<AuthServices>()
          .verifyOtp(
            VerifyOtpReqModel(
              phoneNumber: state.phoneController.text,
              countryCode: state.phoneCountry?.dialCode,
              isoCode: state.phoneCountry?.countryCode,
              otp: state.otpController.text,
              type: state.isRegister ? 1 : 2,
              country: state.selectedCountry?.name,
            ),
            cancelToken: cancelToken,
          )
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) async {
              if (!isClosed) emit(state.copyWith(isVerifyOtpLoad: false));
              value.message.successToast;
              context.read<OtpTimerCubit>().stopTime();

              if (value.data?.accessToken != null) {
                await getIt<StorageService>().saveAccessToken(
                  value.data!.accessToken!,
                );
              }
              if (value.data?.refreshToken != null) {
                await getIt<StorageService>().saveRefreshToken(
                  value.data!.refreshToken!,
                );
              }

              redirect(context, value.data);
              debugPrint('Login successful: ${value.data?.accessToken}');
            },
            onFailed: (value) {
              if (!isClosed) emit(state.copyWith(isVerifyOtpLoad: false));
            },
          );
    } catch (e) {
      if (!isClosed) emit(state.copyWith(isVerifyOtpLoad: false));
    }
  }

  void redirect(BuildContext context, VerifyOtpResModel? value) {
    if (value?.user?.isOnboardingCompleted == 2) {
      context.read<ProfileCubit>().getProfile(context, showToast: true);
    } else {
      if (state.isRegister) {
        context.go(AppRoutes.tellUsAbout);
      } else {
        context.go(AppRoutes.compatibilityRing);
      }
    }
  }
}

class OtpTimerCubit extends Cubit<OtpTimerState> {
  OtpTimerCubit() : super(const OtpTimerState(time: kDebugMode ? 10 : 60));
  Timer? _timer;
  void startTime({bool? isRestart}) {
    if (isRestart ?? false) {
      _timer?.cancel();
      _timer = null;
      emit(const OtpTimerState(time: kDebugMode ? 10 : 60));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.time > 0) {
        emit(state.copyWith(time: state.time - 1));
      } else {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  void stopTime() {
    _timer?.cancel();
    _timer = null;
    emit(const OtpTimerState(time: kDebugMode ? 10 : 60));
  }
}

class LoginTapCubit extends Cubit<LoginState> {
  LoginTapCubit() : super(const LoginState(isTap: false));
  void onTap() {
    emit(state.copyWith(isTap: true));
  }
}
