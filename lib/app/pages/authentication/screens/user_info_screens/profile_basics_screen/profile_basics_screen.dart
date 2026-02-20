import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/cubit/profile_basics_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/cubit/profile_basics_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/validator.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_animated_dropdown.dart';
import 'package:ryann_dating/app/widgets/custom_form_filed.dart';
import 'package:ryann_dating/app/widgets/custom_slider.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';

class ProfileBasicsScreen extends StatelessWidget {
  const ProfileBasicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBasicsCubit(),
      child: BlocBuilder<ProfileBasicsCubit, ProfileBasicsState>(
        builder: (context, state) {
          final cubit = context.read<ProfileBasicsCubit>();
          return Form(
            child: CommonAuthScreen(
              header: context.l10n.profileBasics,
              subText: context.l10n.aFewDetailsOptional,
              subTextTopPad: 8.h,
              btmWidget: Column(
                mainAxisSize: .min,
                children: [
                  Container(
                    margin: 16.btmPad.add(5.topPad),
                    padding: 12.allPad,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: .1),
                      borderRadius: 12.radius,
                    ),
                    child: Text(
                      context.l10n.everythingOptionalNotice,
                      style: AppTextStyle.s12w400(
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ),
                  Row(
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
                        child: Builder(
                          builder: (context) {
                            return CommonBtn(
                              title: context.l10n.saveAndContinue,
                              isLoading: state.isLoading,
                              onTap: () {
                                if (Form.of(context).validate()) {
                                  context.push(
                                    AppRoutes.reviewDetails,
                                    extra: cubit,
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: 24.topPad,
                  child: _InterestedInSelector(
                    selected: state.interestedIn,
                    onChanged: cubit.updateInterestedIn,
                  ),
                ),
                AppTextField(
                  title: context.l10n.location,
                  textInputAction: .done,
                  hintLabel: context.l10n.enterYourSuburbOrCity,
                  controller: state.locationController,
                  titleStyle: AppTextStyle.s12w500(
                    color: AppColors.textPrimaryColor,
                  ),
                  validator: (value) => TextValidator.validate(
                    value,
                    error: 'Please enter your suburb or city',
                  ),
                ),
                CustomRangeSlider(
                  title: context.l10n.ageRange,
                  values: state.ageRange,
                  min: 18,
                  max: 100,
                  onChanged: cubit.updateAgeRange,
                ),
                CustomSlider(
                  title: context.l10n.matchDistance,
                  value: state.matchDistance,
                  min: 1,
                  max: 100,
                  unit: 'km',
                  onChanged: cubit.updateMatchDistance,
                ),
                CustomAnimatedDropdown(
                  title: context.l10n.height,
                  hint: context.l10n.selectYourHeight,
                  value: state.height,
                  error: 'Please select your height',
                  items: const [
                    '155 cm',
                    '160 cm',
                    '165 cm',
                    '170 cm',
                    '175 cm',
                    '180 cm',
                    '185 cm',
                    'Prefer not to say',
                  ],
                  onChanged: cubit.updateHeight,
                ),
                CustomAnimatedDropdown(
                  title: context.l10n.occupation,
                  hint: context.l10n.yourRoleOrTitle,
                  value: state.occupation,
                  error: 'Please select your occupation',
                  items: const [
                    'Healthcare',
                    'Education',
                    'Finance',
                    'Hospitality',
                    'Tech',
                    'Construction',
                    'Retail',
                    'Legal',
                    'Self-Employed',
                    'Student',
                    'Prefer not to say',
                  ],
                  onChanged: cubit.updateOccupation,
                ),
                CustomAnimatedDropdown(
                  title: context.l10n.education,
                  hint: context.l10n.highestLevel,
                  value: state.education,
                  error: 'Please select your education',
                  items: const [
                    'High School',
                    'Certificate / Diploma',
                    "Bachelor's Degree",
                    "Master's Degree",
                    'PhD',
                    'Currently Studying',
                    'Prefer not to say',
                  ],
                  onChanged: cubit.updateEducation,
                ),
                CustomAnimatedDropdown(
                  title: context.l10n.religion,
                  hint: context.l10n.selectYourReligion,
                  value: state.religion,
                  error: 'Please select your religion',
                  items: const [
                    'Catholic',
                    'Christian',
                    'Muslim',
                    'Jewish',
                    'Hindu',
                    'Buddhist',
                    'Sikh',
                    'Spiritual',
                    'No Religion',
                    'Prefer not to say',
                  ],
                  onChanged: cubit.updateReligion,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InterestedInSelector extends StatelessWidget {
  const _InterestedInSelector({
    required this.selected,
    required this.onChanged,
  });

  final InterestedIn? selected;
  final ValueChanged<InterestedIn> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomFormFiled(
      value: selected,
      error: 'Please select your interest',
      builder: (filed) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.interestedIn,
              style: AppTextStyle.s12w500(color: AppColors.textPrimaryColor),
            ),
            Container(
              margin: 8.topPad,
              decoration: BoxDecoration(
                borderRadius: 12.radius,
                border: Border.all(
                  color: filed.hasError
                      ? AppColors.errorColor
                      : AppColors.borderColor,
                ),
              ),
              child: Row(
                children: [
                  _buildOption(
                    context,
                    InterestedIn.men,
                    context.l10n.men,
                    isFirst: true,
                  ),
                  _buildOption(context, InterestedIn.women, context.l10n.women),
                  _buildOption(
                    context,
                    InterestedIn.everyone,
                    context.l10n.everyone,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOption(
    BuildContext context,
    InterestedIn value,
    String label, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final isSelected = selected == value;
    return Expanded(
      child: InkWell(
        onTap: () => onChanged(value),
        child: Container(
          padding: 10.vertPad,
          decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: AppColors.primaryColor)
                : Border(
                    right: isLast
                        ? BorderSide.none
                        : const BorderSide(color: AppColors.borderColor),
                  ),
            borderRadius: isSelected
                ? isFirst
                      ? BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          bottomLeft: Radius.circular(12.r),
                        )
                      : isLast
                      ? BorderRadius.only(
                          topRight: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r),
                        )
                      : .zero
                : .zero,
            color: isSelected
                ? AppColors.primaryColor.withValues(alpha: .1)
                : AppColors.transparent,
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyle.s14w400(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.textPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
