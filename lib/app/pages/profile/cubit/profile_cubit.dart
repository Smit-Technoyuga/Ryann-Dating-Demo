import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/profile_res/profile_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/compatibility_ring_screen.dart';
import 'package:ryann_dating/app/pages/profile/cubit/profile_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/cancellable_cubit.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState>
    with CancellableCubit<ProfileState> {
  ProfileCubit(this._authServices) : super(const ProfileState());

  final AuthServices _authServices;

  Future<void> getProfile(
    BuildContext context, {
    bool showToast = false,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _authServices
          .getProfile(cancelToken: cancelToken)
          .handler(
            showToast: showToast,
            onSuccess: (value) {
              if (!isClosed) {
                emit(state.copyWith(profile: value.data, isLoading: false));
              }
              redirectOnboarding(context, value.data?.onboardingStep);
            },
            onFailed: (value) {
              if (!isClosed) emit(state.copyWith(isLoading: false));
            },
          );
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(error: e.toString(), isLoading: false));
      }
    }
  }

  void redirectOnboarding(BuildContext context, int? step) {
    switch (step) {
      case 1:
        context.go(AppRoutes.tellUsAbout);
      case 2:
        context.go(AppRoutes.membershipScreen);
      case 3:
        context.go(AppRoutes.addPhoto);
      case 4:
        context.go(AppRoutes.photoVerification);
      case 5:
        context.go(
          AppRoutes.welcomeIntentionSelection,
          extra: state.profile?.intention,
        );
      case 6:
        context.go(AppRoutes.profileBasics);
      case 7:
        context.go(AppRoutes.interests, extra: state.profile?.interests ?? []);
      case 8:
        context.go(AppRoutes.aboutMe);
      case 9:
        context.go(AppRoutes.prompts, extra: state.profile?.promptsData);
      case 10:
        naviagteToCompability(context, state.profile);
      default:
        context.go(AppRoutes.dashboard);
    }
  }

  void naviagteToCompability(BuildContext context, ProfileModel? profile) {
    if ((profile?.compatibilityQuestionAnsweredCount ?? 0) >=
        (profile?.compatibilityQuestionCount ?? 0)) {
      context.go(AppRoutes.dashboard);
    } else {
      context.go(
        AppRoutes.compatibilityRing,
        extra: CompatibilityRingScreenArgs(
          compatibilityRing: profile?.compatibilityRing,
          queCount: profile?.compatibilityQuestionCount,
          answeredQue: profile?.compatibilityQuestionAnsweredCount,
          compatibilityAnswers: profile?.compatibilityAnswers,
        ),
      );
    }
  }

  void clearProfile() {
    emit(const ProfileState());
  }
}
