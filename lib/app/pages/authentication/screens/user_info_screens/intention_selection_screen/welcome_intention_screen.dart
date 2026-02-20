import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class WelcomeIntentionScreen extends StatelessWidget {
  const WelcomeIntentionScreen({super.key, required this.intentions});
  final List<IntentionModel> intentions;

  @override
  Widget build(BuildContext context) {
    return CommonAuthScreen(
      header: context.l10n.welcomeToRyann,
      subText: context.l10n.honestConnectionsMessage,
      subTextTopPad: 8.h,
      btmWidget: Column(
        spacing: 24.w,
        mainAxisSize: .min,
        children: [
          CommonBtn(
            title: context.l10n.letsGetYouSetUp,
            onTap: () => context.go(AppRoutes.intentionSelection, extra: intentions),
          ),
          Text(
            context.l10n.onlyRealPeople,
            style: AppTextStyle.s14w400(color: AppColors.textLightColor),
          ),
        ],
      ),
      children: [
        Padding(
          padding: 32.topPad,
          child: Text(
            context.l10n.verifiedCommunityMessage,
            style: AppTextStyle.s16w400(color: AppColors.textPrimaryColor),
          ),
        ),
        Padding(
          padding: 16.vertPad,
          child: Text(
            context.l10n.noDistractions,
            style: AppTextStyle.s16w400(color: AppColors.textPrimaryColor),
          ),
        ),
        Text(
          context.l10n.peopleMeanWhatTheySay,
          style: AppTextStyle.s16w400(color: AppColors.textPrimaryColor),
        ),
      ],
    );
  }
}
