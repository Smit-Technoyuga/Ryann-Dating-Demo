import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class IntentionSetSuccessScreen extends StatelessWidget {
  const IntentionSetSuccessScreen({super.key, required this.intentions});

  final List<IntentionModel> intentions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: Padding(
        padding: context.bottomPad.btmPad.add(24.horPad),
        child: CommonBtn(
          title: context.l10n.continues,
          onTap: () => context.go(AppRoutes.intentionLocked, extra: intentions),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: 24.horPad,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: Assets.logo.logoBlack.path,
                width: 139.w,
              ),
              Padding(
                padding: 16.btmPad.add(60.topPad),
                child: Text(
                  context.l10n.greatChoiceAllSet,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.s20w500(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
              Text(
                context.l10n.intentionLockedFor30Days,
                textAlign: TextAlign.center,
                style: AppTextStyle.s14w400(color: AppColors.textLightColor),
              ),
              Padding(
                padding: 16.topPad,
                child: Text(
                  context.l10n.keepsExpectationsClear,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.s14w400(color: AppColors.textLightColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
