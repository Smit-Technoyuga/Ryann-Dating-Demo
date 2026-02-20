import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/auth_services/auth_services.dart';
import 'package:ryann_dating/app/data/models/auth_models/request_models/waiting_list_req/waiting_list_req.dart';
import 'package:ryann_dating/app/pages/authentication/screens/join_wishlist_screen/cubit/join_wishlist_state.dart';
import 'package:ryann_dating/app/utils/exception/exception.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/helper/cancellable_cubit.dart';
import 'package:ryann_dating/app/utils/helper/countries_list.dart';
import 'package:ryann_dating/app/utils/helper/injectable/injectable.dart';
import 'package:ryann_dating/app/widgets/sucess_dialog.dart';

class JoinWishlistCubit extends Cubit<JoinWishlistState>
    with CancellableCubit<JoinWishlistState> {
  JoinWishlistCubit()
    : super(
        JoinWishlistState(
          emailController: TextEditingController(),
          nameController: TextEditingController(),
          // Initialize your other fields here
        ),
      );

  void selectCountry(CountryCode country) {
    emit(state.copyWith(selectedCountry: country));
  }

  Future<void> checkWaitingList(BuildContext context) async {
    if (cancelToken.isCancelled) return;
    emit(state.copyWith(isWaitLoad: true));
    try {
      await getIt<AuthServices>()
          .checkWaitingList(
            WaitingListReq(
              name: state.nameController.text,
              email: state.emailController.text,
              country: state.selectedCountry?.name,
              isoCode: state.selectedCountry?.countryCode,
              countryCode: state.selectedCountry?.dialCode,
              cityStatus: 'WAITLIST',
              countryStatus: 'WAITLIST',
            ),
            cancelToken: cancelToken,
          )
          .handler(
            isLoading: false,
            showToast: true,
            onSuccess: (value) {
              emit(state.copyWith(isWaitLoad: false));
              showSucessDialog(
                context,
                title: context.l10n.thanksForYourInterest,
                subTitle: context.l10n.notifyLaunchMessage,
                btnText: context.l10n.okay,
                onTap: () => context.pop(),
              );
            },
            onFailed: (value) {
              emit(state.copyWith(isWaitLoad: false));
            },
          );
    } catch (e) {
      emit(state.copyWith(isWaitLoad: false));
    }
  }
}
