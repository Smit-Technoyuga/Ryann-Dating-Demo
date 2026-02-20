import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/cubit/photo_verification_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/cubit/photo_verification_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class PhotoVerificationScreen extends StatelessWidget {
  const PhotoVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAuthScreen(
      header: context.l10n.getPhotoVerified,
      subText: context.l10n.quickSelfieCheck,
      subTextTopPad: 8.h,
      btmWidget: BlocProvider(
        create: (context) => PhotoVerificationCubit(),
        child: BlocBuilder<PhotoVerificationCubit, PhotoVerificationState>(
          builder: (context, state) {
            final cubit = context.read<PhotoVerificationCubit>();
            return Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CommonBtn(
                    title: context.l10n.whyThisMatters,
                    btnColor: AppColors.transparent,
                    borderColor: AppColors.primaryColor,
                    txtColor: AppColors.primaryColor,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: CommonBtn(
                    title: context.l10n.startVerification,
                    isLoading: state.isLoading,
                    onTap: () => cubit.verifyPhotos(context),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      children: [
        Padding(
          padding: 24.topPad,
          child: Text(
            context.l10n.everyoneVerifiedInfo,
            style: AppTextStyle.s14w400(color: AppColors.textLightColor),
          ),
        ),
        Container(
          margin: 8.vertPad,
          padding: 12.allPad,
          decoration: BoxDecoration(
            color: AppColors.lightGreenColor2,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            '${context.l10n.photoVerifiedBadgeInfo} ✅',
            style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
          ),
        ),
        Padding(
          padding: 24.btmPad,
          child: Text(
            context.l10n.verificationBenefits,
            style: AppTextStyle.s14w400(color: AppColors.textLightColor),
          ),
        ),
        Text(
          context.l10n.whatToExpect,
          style: AppTextStyle.s16w500(color: AppColors.textPrimaryColor),
        ),
        _buildExpectationItem(
          context,
          icon: '🕐',
          text: context.l10n.takesLessThanTwoMinutes,
        ),
        _buildExpectationItem(
          context,
          icon: '✅',
          text: context.l10n.requiredToJoin,
        ),
        _buildExpectationItem(
          context,
          icon: '🔒',
          text: context.l10n.privateAndSecure,
        ),
      ],
    );
  }

  Widget _buildExpectationItem(
    BuildContext context, {
    required String icon,
    required String text,
  }) {
    return Padding(
      padding: 16.topPad,
      child: Row(
        spacing: 12.w,
        mainAxisAlignment: .center,
        children: [
          Text(icon, style: TextStyle(fontSize: 20.sp)),
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.s16w400(color: AppColors.textPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
