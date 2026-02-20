import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/interests_screen/cubit/interests_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/interests_screen/cubit/interests_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterestsCubit, InterestsState>(
      builder: (context, state) {
        final cubit = context.read<InterestsCubit>();
        return CommonAuthScreen(
          header: context.l10n.whatAreYouInto,
          subText: context.l10n.chooseUpToEight,
          subTextTopPad: 8.h,
          btmWidget: Padding(
            padding: 10.topPad,
            child: Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CommonBtn(
                    title: context.l10n.goBack,
                    onTap: context.pop,
                    btnColor: AppColors.whiteColor,
                    txtColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: CommonBtn(
                    title: context.l10n.saveAndContinue,
                    isLoading: state.isLoading,
                    onTap: () => cubit.saveInterests(context),
                  ),
                ),
              ],
            ),
          ),
          children: [
            ...state.interests.map(
              (category) => _buildCategoryList(
                context,
                category.category ?? '',
                (category.options ?? [])
                    .map((option) => _InterestItem(option, option))
                    .toList(),
                state,
                cubit,
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              context.l10n.howImportantToShareInterests,
              style: AppTextStyle.s16w600(color: AppColors.textPrimaryColor),
            ),
            SizedBox(height: 8.h),
            _buildImportanceOption(
              context,
              context.l10n.yesItsImportant,
              SharingImportance.important,
              state.sharingImportance,
              cubit,
            ),
            _buildImportanceOption(
              context,
              context.l10n.iDontMind,
              SharingImportance.dontMind,
              state.sharingImportance,
              cubit,
            ),
            _buildImportanceOption(
              context,
              context.l10n.noItsNotImportant,
              SharingImportance.notImportant,
              state.sharingImportance,
              cubit,
            ),
            SizedBox(height: 32.h),
          ],
        );
      },
    );
  }

  Widget _buildCategoryList(
    BuildContext context,
    String title,
    List<_InterestItem> items,
    InterestsState state,
    InterestsCubit cubit,
  ) {
    return Padding(
      padding: 24.topPad,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: 8.btmPad,
            child: Text(
              title,
              style: AppTextStyle.s18w500(color: AppColors.textPrimaryColor),
            ),
          ),
          ...items.map((item) {
            final isSelected = state.selectedInterests.contains(item.key);
            return InkWell(
              onTap: () => cubit.toggleInterest(item.key),
              child: Padding(
                padding: 8.vertPad,
                child: Row(
                  spacing: 16.w,
                  children: [
                    SizedBox(
                      height: 20.w,
                      width: 20.w,
                      child: Container(
                        margin: 1.5.allPad,
                        decoration: BoxDecoration(
                          shape: .circle,
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.transparent,
                          border: .all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.color6C757D,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      item.label,
                      style: AppTextStyle.s14w400(
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildImportanceOption(
    BuildContext context,
    String label,
    SharingImportance value,
    SharingImportance? selectedValue,
    InterestsCubit cubit,
  ) {
    final isSelected = value == selectedValue;
    return InkWell(
      onTap: () => cubit.updateSharingImportance(value),
      child: Padding(
        padding: 8.vertPad,
        child: Row(
          spacing: 16.w,
          children: [
            SizedBox(
              height: 20.w,
              width: 20.w,
              child: Container(
                margin: 1.5.allPad,
                decoration: BoxDecoration(
                  shape: .circle,
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.transparent,
                  border: .all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.color6C757D,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            Text(
              label,
              style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _InterestItem {
  _InterestItem(this.label, this.key);
  final String label;
  final String key;
}
