import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/pages/authentication/screens/membership_screen/cubit/membership_state.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';

class MembershipCubit extends Cubit<MembershipState> {
  MembershipCubit() : super(const MembershipState());

  Future<void> takeMembership() async {
    emit(state.copyWith(isLoading: true));

    try {
      await getIt<AuthServices>().takeMembership().handler(
        isLoading: false,
        showToast: true,
        onSuccess: (value) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
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
