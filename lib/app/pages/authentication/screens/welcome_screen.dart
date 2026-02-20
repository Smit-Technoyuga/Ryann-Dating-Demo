import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/constants/common_sizes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/status_bar_theme.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: StatusBarTheme.welcomeScreen,
      child: Scaffold(
        body: Stack(
          children: [
            CustomImageView(
              imagePath: Assets.images.welcomeBack.path,
              width: context.width,
              fit: .cover,
            ),
            Positioned(
              top: 120.h,
              left: 0,
              right: 0,
              child: CustomImageView(
                imagePath: Assets.logo.logoNameWhiteIc,
                width: 240.w,
              ),
            ),
            Positioned(
              left: CommonSizes.commonPad,
              right: CommonSizes.commonPad,
              bottom: context.bottomPad,
              child: Column(
                children: [
                  Text(
                    context.l10n.byTappingCreateAccount,
                    textAlign: .center,
                    style: AppTextStyle.s12w400(),
                  ),
                  CommonBtn(
                    title: context.l10n.createAccount,
                    margin: 16.vertPad,
                    btnColor: AppColors.darkPrimary,
                    borderColor: AppColors.darkPrimary,
                    onTap: () => context.push(AppRoutes.citySelectionScreen),
                  ),
                  CommonBtn(
                    title: context.l10n.signIn,
                    borderColor: AppColors.whiteColor,
                    margin: 16.btmPad,
                    btnColor: AppColors.transparent,
                    onTap: () => context.push(AppRoutes.login),
                  ),
                  Text(
                    context.l10n.troubleInSigningIn,
                    textAlign: .center,
                    style: AppTextStyle.s16w500(color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
