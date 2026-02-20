import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class IntentionLockedScreen extends StatelessWidget {
  const IntentionLockedScreen({super.key, required this.intentions});

  final List<IntentionModel> intentions;

  @override
  Widget build(BuildContext context) {
    return CommonAuthScreen(
      header: context.l10n.youCantChangeThisYet,
      subText: context.l10n.intentionLockedInfo,
      headerStyle: AppTextStyle.s22w600(),
      subTextTopPad: 8.h,
      btmWidget: CommonBtn(
        title: context.l10n.gotIt,
        onTap: () => context.go(AppRoutes.profileBasics),
      ),
      children: [
        Padding(
          padding: 24.topPad,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                context.l10n.youCanUpdateThisAgainOn,
                style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
              ),

              Padding(
                padding: 8.vertPad,
                child: Text(
                  DateFormat(
                    'dd MMM, yyyy',
                  ).format(DateTime.now().add(const Duration(days: 30))),
                  style: AppTextStyle.s16w600(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () =>
                    context.push(AppRoutes.intentionsList, extra: intentions),
                child: Text(
                  context.l10n.intentionsList,
                  style: AppTextStyle.s14w400(color: AppColors.primaryColor)
                      .copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
