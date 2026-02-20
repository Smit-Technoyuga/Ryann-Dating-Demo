import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/membership_screen/cubit/membership_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/membership_screen/cubit/membership_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MembershipCubit(),
      child: BlocConsumer<MembershipCubit, MembershipState>(
        listener: (context, state) {
          if (state.isSuccess) {
            context.go(AppRoutes.addPhoto);
          }
        },
        builder: (context, state) {
          return CommonAuthScreen(
            header: context.l10n.activateMembershipPass,
            headerStyle: AppTextStyle.s28w600(),
            subText: context.l10n.oneTimeStepNote,
            subTextTopPad: 8.h,
            btmWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonBtn(
                  title: '${context.l10n.activatePass} — \$4.99',
                  isLoading: state.isLoading,
                  onTap: () => context.read<MembershipCubit>().takeMembership(),
                ),
                Container(
                  margin: 16.topPad,
                  padding: 12.allPad,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    spacing: 12.w,
                    children: [
                      CustomImageView(imagePath: Assets.svgIcons.infoIc),
                      Expanded(
                        child: Text(
                          context.l10n.passCreditInfo('4.99'),
                          style: AppTextStyle.s12w400(
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            children: [
              Container(
                width: double.infinity,
                padding: 24.allPad,
                margin: 32.topPad,
                decoration: BoxDecoration(
                  color: AppColors.lightGreenColor2,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$4.99 · ${context.l10n.fullyRedeemable}',
                      style: AppTextStyle.s16w400(
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    Padding(
                      padding: 12.vertPad,
                      child: Text(
                        context.l10n.oneTimePassDescription,
                        style: AppTextStyle.s14w400(
                          color: AppColors.blackColor,
                        ).copyWith(height: 1.5),
                      ),
                    ),
                    Text(
                      context.l10n.notSubscription,
                      style: AppTextStyle.s14w500(color: AppColors.blackColor),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
