import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/preferences_req_model/preferences_req_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/cubit/profile_basics_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class ProfileBasicsCubit extends Cubit<ProfileBasicsState> {
  ProfileBasicsCubit()
    : super(ProfileBasicsState(locationController: TextEditingController()));

  void updateInterestedIn(InterestedIn value) {
    emit(state.copyWith(interestedIn: value));
  }

  void updateAgeRange(RangeValues value) {
    emit(state.copyWith(ageRange: value));
  }

  void updateMatchDistance(double value) {
    emit(state.copyWith(matchDistance: value));
  }

  void updateHeight(String? value) {
    emit(state.copyWith(height: value));
  }

  void updateOccupation(String? value) {
    emit(state.copyWith(occupation: value));
  }

  void updateEducation(String? value) {
    emit(state.copyWith(education: value));
  }

  void updateReligion(String? value) {
    emit(state.copyWith(religion: value));
  }

  Future<void> savePreferences(BuildContext context) async {
    emit(state.copyWith(isLoading: true));

    final interestedIn = state.interestedIn == InterestedIn.men
        ? 'male'
        : state.interestedIn == InterestedIn.women
        ? 'female'
        : 'both';

    try {
      final req = PreferencesReqModel(
        interestedIn: interestedIn,
        ageRangeMin: state.ageRange.start.toInt(),
        ageRangeMax: state.ageRange.end.toInt(),
        matchDistanceKm: state.matchDistance.toInt(),
        height: int.tryParse(state.height?.split(' ').first ?? '0') ?? 0,
        occupation: state.occupation ?? '',
        education: state.education ?? '',
        religion: state.religion ?? '',
      );

      await getIt<AuthServices>()
          .updatePreferences(req)
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              emit(state.copyWith(isLoading: false, isSuccess: true));
              context.push(
                AppRoutes.interests,
                extra: value.data?.interests ?? [],
              );
            },
            onFailed: (value) {
              emit(state.copyWith(isLoading: false));
            },
          );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  @override
  Future<void> close() {
    state.locationController.dispose();
    return super.close();
  }
}
