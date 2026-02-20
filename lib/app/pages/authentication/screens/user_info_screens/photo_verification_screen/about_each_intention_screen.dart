import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/intention_selection_screen/cubit/intention_selection_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';

class AboutEachIntentionScreen extends StatelessWidget {
  const AboutEachIntentionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IntentionSelectionCubit(context: context),
      child: BlocBuilder<IntentionSelectionCubit, IntentionSelectionState>(
        builder: (context, state) {
          return CommonAuthScreen(
            header: context.l10n.aboutEachIntention,
            children: [
              SizedBox(height: 16.h),
              ...List.generate(state.intentions.length * 2 - 1, (index) {
                if (index.isOdd) {
                  return Divider(color: AppColors.borderColor, height: 16.h);
                }
                final intention = state.intentions[index ~/ 2];
                return Padding(
                  padding: 16.vertPad,
                  child: Column(
                    spacing: 8.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        intention.label ?? '',
                        style: AppTextStyle.s14w400(
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      Text(
                        intention.description ?? '',
                        style: AppTextStyle.s12w400(
                          color: AppColors.textLightColor,
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
