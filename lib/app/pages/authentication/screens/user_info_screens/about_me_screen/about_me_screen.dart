import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/about_me_screen/cubit/about_me_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/about_me_screen/cubit/about_me_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/app/widgets/custom_radio_btn.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AboutMeCubit, AboutMeState>(
      builder: (context, state) {
        final cubit = context.read<AboutMeCubit>();
        return CommonAuthScreen(
          header: context.l10n.aboutMe,
          subText: context.l10n.yourStoryMatters,
          subTextTopPad: 8.h,
          btmWidget: CommonBtn(
            title: context.l10n.saveAndContinue,
            isLoading: state.isLoading,
            onTap: () => context.read<AboutMeCubit>().saveBio(context),
          ),
          children: [
            Padding(
              padding: 24.topPad,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  AppTextField(
                    controller: state.aboutMeController,
                    hintLabel: context.l10n.writeSomethingShort,
                    type: .multiline,
                    textInputAction: .newline,
                    minLines: 6,
                    maxLines: 6,
                    bottomPad: 8.h,
                    maxLength: 250,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ValueListenableBuilder(
                      valueListenable: state.aboutMeController,
                      builder: (context, controller, child) {
                        return Text(
                          '${controller.text.length}/250',
                          style: AppTextStyle.s12w400(
                            color: AppColors.textGreyColor,
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: 20.topPad,
                    child: _buildAiBanner(context, cubit),
                  ),
                  if (state.isAiHelpActive) ...[
                    Padding(
                      padding: 12.topPad,
                      child: _buildToneSelection(context, state, cubit),
                    ),
                    if (state.isGenerating)
                      const Center(child: CircularProgressIndicator())
                    else if (state.suggestions.isNotEmpty)
                      Padding(
                        padding: 12.topPad,
                        child: _buildSuggestions(context, state, cubit),
                      ),
                  ],

                  Container(
                    margin: 20.topPad,
                    width: double.infinity,
                    padding: 12.allPad,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: 12.radius,
                    ),
                    child: Text(
                      context.l10n.bioAnytimeNote,
                      style: AppTextStyle.s12w400(
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAiBanner(BuildContext context, AboutMeCubit cubit) {
    return InkWell(
      onTap: cubit.toggleAiHelp,
      child: Row(
        crossAxisAlignment: .start,
        spacing: 8.w,
        children: [
          CustomImageView(
            imagePath: Assets.svgIcons.aiStarIc,
            height: 24.w,
            width: 24.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 8.h,
              children: [
                Text(
                  context.l10n.useAiToHelp,
                  style: AppTextStyle.s16w500(
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                Text(
                  context.l10n.stuckLetAiHelp,
                  style: AppTextStyle.s14w400(color: AppColors.textGreyColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToneSelection(
    BuildContext context,
    AboutMeState state,
    AboutMeCubit cubit,
  ) {
    return Column(
      children: [
        _buildToneOption(
          context,
          context.l10n.warm,
          AboutMeTone.warm,
          state.selectedTone,
          cubit,
        ),
        _buildToneOption(
          context,
          context.l10n.playful,
          AboutMeTone.playful,
          state.selectedTone,
          cubit,
        ),
        _buildToneOption(
          context,
          context.l10n.confident,
          AboutMeTone.confident,
          state.selectedTone,
          cubit,
        ),
        _buildToneOption(
          context,
          context.l10n.minimal,
          AboutMeTone.minimal,
          state.selectedTone,
          cubit,
        ),
      ],
    );
  }

  Widget _buildToneOption(
    BuildContext context,
    String label,
    AboutMeTone tone,
    AboutMeTone? selectedTone,
    AboutMeCubit cubit,
  ) {
    final isSelected = tone == selectedTone;
    return InkWell(
      onTap: () => cubit.selectTone(tone),
      child: Padding(
        padding: 8.vertPad,
        child: Row(
          spacing: 16.w,
          children: [
            CustomRadioBtn(isSelected: isSelected),
            Text(
              label,
              style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions(
    BuildContext context,
    AboutMeState state,
    AboutMeCubit cubit,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...state.suggestions.asMap().entries.map((entry) {
          final index = entry.key;
          final suggestion = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.suggestionN(index + 1),
                style: AppTextStyle.s14w500(color: AppColors.textPrimaryColor),
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: 16.allPad,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      suggestion,
                      style: AppTextStyle.s14w400(
                        color: AppColors.textGreyColor,
                      ),
                    ),
                    Divider(height: 16.h, color: AppColors.borderColor),
                    InkWell(
                      onTap: () => cubit.useSuggestion(suggestion),
                      child: Text(
                        context.l10n.useThis,
                        style: AppTextStyle.s14w500(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          );
        }),
      ],
    );
  }
}
