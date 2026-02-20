import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/basic_info_req_model/basic_info_req_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_state.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/utils/helper/cancellable_cubit.dart';

enum Gender { Male, Female, Other }

class BasicInfoCubit extends Cubit<BasicInfoState>
    with CancellableCubit<BasicInfoState> {
  BasicInfoCubit()
    : super(
        BasicInfoState(
          nameController: TextEditingController(),
          dobControllers: List.generate(8, (index) => TextEditingController()),
          dobFocusNodes: List.generate(8, (index) => FocusNode()),
        ),
      ) {
    for (final controller in state.dobControllers) {
      controller.addListener(() {
        emit(state.copyWith());
      });
    }
  }

  DateTime? getDob() {
    if (state.dobText.length != 8) return null;
    return DateTime(
      int.parse(state.dobText.substring(4, 8)),
      int.parse(state.dobText.substring(2, 4)),
      int.parse(state.dobText.substring(0, 2)),
    );
  }

  void selectGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  void updateDobText() {
    final dobText = state.dobControllers.map((c) => c.text).join();
    emit(state.copyWith(dobText: dobText));
  }

  Future<void> saveBasicInfo(BuildContext context) async {
    final dob = getDob();
    context.pop();
    if (dob == null) return;

    final formattedDob = DateFormat('yyyy-MM-dd').format(dob);

    emit(state.copyWith(isLoading: true));

    try {
      await getIt<AuthServices>()
          .saveBasicInfo(
            BasicInfoReqModel(
              firstName: state.nameController.text,
              dateOfBirth: formattedDob,
              gender: state.gender?.name ?? '',
            ),
            cancelToken: cancelToken,
          )
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              if (!isClosed) {
                emit(state.copyWith(isLoading: false, isSuccess: true));
              }
              context.go(AppRoutes.membershipScreen);
            },
            onFailed: (value) {
              if (!isClosed) emit(state.copyWith(isLoading: false));
            },
          );
    } catch (e) {
      if (!isClosed) emit(state.copyWith(isLoading: false));
    }
  }
}
