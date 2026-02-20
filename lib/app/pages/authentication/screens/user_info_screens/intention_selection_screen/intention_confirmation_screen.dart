import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/sucess_dialog.dart';

class IntentionConfirmationScreen extends StatelessWidget {
  const IntentionConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntentionSelectionCubit, IntentionSelectionState>(
      builder: (context, state) {
        final item = state.intentions[state.selectedIndex];
        return CommonAuthScreen(
          header: item.label,
          subText: item.description,
          subTextTopPad: 8.h,
          btmWidget: Column(
            mainAxisSize: .min,
            spacing: 24.h,
            children: [
              CommonBtn(
                title: context.l10n.confirmIntention,
                isLoading: state.isLoading,
                onTap: () =>
                    context.read<IntentionSelectionCubit>().setIntention(),
              ),
              GestureDetector(
                onTap: () => context.pop(),
                child: Text(
                  context.l10n.chooseDifferentOne,
                  style: AppTextStyle.s14w400(color: AppColors.textLightColor),
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: 32.topPad,
              child: Column(
                spacing: 8.h,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    context.l10n.datingIntentionLockWarning,
                    style: AppTextStyle.s14w400(
                      color: AppColors.textLightColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showSucessDialog(
                        context,
                        title: context.l10n.whyIsMyIntentionLockedFor30Days,
                        titleStyle: AppTextStyle.s22w500(
                          color: AppColors.textPrimaryColor,
                        ),
                        subTitle:
                            context.l10n.whyIsMyIntentionLockedFor30DaysDesc,
                        btnText: context.l10n.gotIt,
                        onTap: context.pop,
                      );
                    },
                    child: Text(
                      context.l10n.whyIsItLocked,
                      style: AppTextStyle.s14w400(
                        color: AppColors.textLightColor,
                      ).copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
