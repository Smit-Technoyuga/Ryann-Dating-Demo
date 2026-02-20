import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/interests_req_model/interests_req_model.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/interest_model/interest_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/interests_screen/cubit/interests_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/string_ext.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class InterestsCubit extends Cubit<InterestsState> {
  InterestsCubit(this.context, {List<InterestModel> interests = const []})
    : super(InterestsState(interests: interests));
  final BuildContext context;

  void toggleInterest(String interest) {
    final currentSelected = Set<String>.from(state.selectedInterests);
    if (currentSelected.contains(interest)) {
      currentSelected.remove(interest);
    } else {
      if (currentSelected.length < 8) {
        currentSelected.add(interest);
      } else {
        context.l10n.youCanOnlySelect8Interests.errorToast;
      }
    }
    emit(state.copyWith(selectedInterests: currentSelected));
  }

  void checkInterests() {
    if (state.selectedInterests.isEmpty) {
      context.l10n.pleaseSelectAtLeastOneInterest.errorToast;
    } else {
      // context.push(location);
    }
  }

  void updateSharingImportance(SharingImportance importance) {
    emit(state.copyWith(sharingImportance: importance));
  }

  Future<void> saveInterests(BuildContext context) async {
    if (state.selectedInterests.isEmpty) {
      context.l10n.pleaseSelectAtLeastOneInterest.errorToast;
      return;
    }
    if (state.sharingImportance?.name.isEmpty ?? true) {
      context.l10n.pleaseSelectSharingImportance.errorToast;
      return;
    }

    emit(state.copyWith(isLoading: true));

    final sharingImportance = switch (state.sharingImportance) {
      SharingImportance.important => 'important',
      SharingImportance.dontMind => 'neutral',
      SharingImportance.notImportant => 'not_important',
      _ => '',
    };

    try {
      final req = InterestsReqModel(
        interests: state.selectedInterests.toList(),
        sharedInterestImportance: sharingImportance,
      );

      await getIt<AuthServices>()
          .updateInterests(req)
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              emit(state.copyWith(isLoading: false));
              context.push(AppRoutes.aboutMe);
            },
            onFailed: (value) {
              emit(state.copyWith(isLoading: false));
            },
          );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
