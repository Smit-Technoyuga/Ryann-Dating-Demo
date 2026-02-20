import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/compatibility_ring_screen.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class CompatibilityQuestionsScreen extends StatelessWidget {
  const CompatibilityQuestionsScreen({super.key, this.args});

  final CompatibilityRingScreenArgs? args;

  @override
  Widget build(BuildContext context) {
    final categories =
        args?.compatibilityRing?.map((e) {
          final parts = (e.label ?? '').split(' ');
          final icon = parts.length > 1 ? parts.last : '';
          final title = parts.length > 1
              ? parts.sublist(0, parts.length - 1).join(' ')
              : e.label ?? '';

          return _CategoryData(
            icon: icon,
            title: title,
            subtitle: e.subtitle ?? '',
          );
        }).toList() ??
        [
          _CategoryData(
            icon: '👶',
            title: context.l10n.familyAndFuture,
            subtitle: context.l10n.familyAndFutureDesc,
          ),
          _CategoryData(
            icon: '🧘',
            title: context.l10n.lifestyleAndHabits,
            subtitle: context.l10n.lifestyleAndHabitsDesc,
          ),
          _CategoryData(
            icon: '🤝',
            title: context.l10n.socialEnergy,
            subtitle: context.l10n.socialEnergyDesc,
          ),
          _CategoryData(
            icon: '💬',
            title: context.l10n.communicationStyle,
            subtitle: context.l10n.communicationStyleDesc,
          ),
          _CategoryData(
            icon: '⚖️',
            title: context.l10n.conflictStyle,
            subtitle: context.l10n.conflictStyleDesc,
          ),
          _CategoryData(
            icon: '❤️',
            title: context.l10n.intimacyExpectations,
            subtitle: context.l10n.intimacyExpectationsDesc,
          ),
          _CategoryData(
            icon: '🌟',
            title: context.l10n.valuesAndPriorities,
            subtitle: context.l10n.valuesAndPrioritiesDesc,
          ),
        ];

    return CommonAuthScreen(
      header: context.l10n.buildCompatibilityRing,
      subText: context.l10n.theMoreYouAnswer,
      subTextTopPad: 8.h,
      btmWidget: Column(
        mainAxisSize: .min,
        spacing: 12.h,
        children: [
          CommonBtn(
            title: context.l10n.buildMyCompatibilityRing,
            onTap: () =>
                context.push(AppRoutes.compatibilityQuestionsList, extra: args),
          ),
          CommonBtn(
            title: context.l10n.skipForNow,
            btnColor: AppColors.transparent,
            borderColor: AppColors.primaryColor.withValues(alpha: 0.5),
            txtColor: AppColors.primaryColor,
            onTap: context.pop,
          ),
        ],
      ),
      children: [
        SizedBox(height: 24.h),
        ...categories.map((category) => _CategoryCard(data: category)),
        Container(
          padding: 12.allPad,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: 12.radius,
          ),
          child: Text(
            context.l10n.answersStayPrivate,
            style: AppTextStyle.s12w400(color: AppColors.blackColor),
          ),
        ),
      ],
    );
  }
}

class _CategoryData {
  const _CategoryData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String icon;
  final String title;
  final String subtitle;
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.data});

  final _CategoryData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 14.btmPad,
      padding: 16.allPad,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: 12.radius,
        border: .all(color: AppColors.blackColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 8.h,
        children: [
          Text(
            '${data.icon} ${data.title}',
            style: AppTextStyle.s16w400(color: AppColors.blackColor),
          ),
          Text(
            data.subtitle,
            style: AppTextStyle.s14w400(color: AppColors.textLightColor),
          ),
        ],
      ),
    );
  }
}
