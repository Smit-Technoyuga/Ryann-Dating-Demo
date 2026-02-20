import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/verify_photos_res/verify_photos_res_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_state.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/intention_selection_screen.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';

class IntentionsListScreen extends StatelessWidget {
  const IntentionsListScreen({super.key, required this.intentions});

  final List<IntentionModel> intentions;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          IntentionSelectionCubit(context: context)..setIntentions(intentions),
      child: BlocBuilder<IntentionSelectionCubit, IntentionSelectionState>(
        builder: (context, state) {
          return CommonAuthScreen(
            header: context.l10n.intentionsList,
            btmWidget: GestureDetector(
              onTap: () => context.push(AppRoutes.aboutEachIntention),
              child: Container(
                padding: 12.allPad,
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: context.l10n.learnMore,
                        style: AppTextStyle.s14w400(
                          color: AppColors.textPrimaryColor,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                      TextSpan(
                        text: ' ${context.l10n.aboutEachOption}',
                        style: AppTextStyle.s14w400(
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            children: [
              SizedBox(height: 16.h),
              ...List.generate(state.intentions.length, (index) {
                final item = state.intentions[index];

                return Padding(
                  padding: 12.btmPad,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: 16.allPad,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Text(
                          item.label ?? '',
                          style: AppTextStyle.s14w400(
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 6.w,
                        top: 6.w,
                        child: InfoIcon(
                          description: context.l10n.lockedFor30Days,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
