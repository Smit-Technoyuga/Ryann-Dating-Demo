import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/data/models/auth_models/res_models/prompt_model/prompt_model.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/cubit/prompts_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/cubit/prompts_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class PromptsScreen extends StatelessWidget {
  const PromptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PromptsCubit, PromptsState>(
      listener: (context, state) {
        if (state.isSuccess) {
          // Navigate to next screen
        }
      },
      builder: (context, state) {
        final cubit = context.read<PromptsCubit>();
        final groupedPrompts = <String, List<PromptModel>>{};
        for (final p in state.prompts) {
          final label = p.categoryLabel ?? 'Other';
          groupedPrompts.putIfAbsent(label, () => []).add(p);
        }

        return CommonAuthScreen(
          header: context.l10n.choose12Prompts,
          subText: context.l10n.promptsHelpYourMatchesGetFeelForYourPersonality,
          btmWidget: Row(
            spacing: 12.w,
            children: [
              Expanded(
                child: CommonBtn(
                  title: context.l10n.skip,
                  btnColor: Colors.transparent,
                  borderColor: AppColors.primaryColor,
                  txtColor: AppColors.primaryColor,
                  onTap: () {},
                ),
              ),
              Expanded(
                child: CommonBtn(
                  title: context.l10n.continues,
                  isLoading: state.isLoading,
                  onTap: () => cubit.submit(context),
                ),
              ),
            ],
          ),
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: 24.vertPad,
                  child: Text(
                    context.l10n.yourAnswersWillAppearOnYourProfile,
                    style: AppTextStyle.s14w400(color: AppColors.textGreyColor),
                  ),
                ),
                ...groupedPrompts.entries.map((entry) {
                  return Padding(
                    padding: 16.btmPad,
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: 16.h,
                      children: [
                        Text(entry.key, style: AppTextStyle.s18w600()),
                        ...entry.value.map((prompt) {
                          final isSelected = state.selectedPrompts.containsKey(
                            prompt.question,
                          );
                          return _buildPromptItem(
                            context,
                            prompt,
                            isSelected,
                            cubit,
                            state,
                          );
                        }),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: 8.topPad,
                  child: Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => state.isLoading
                            ? null
                            : context.push(
                                AppRoutes.customPrompt,
                                extra: cubit,
                              ),
                        child: Row(
                          spacing: 6.w,
                          children: [
                            CustomImageView(
                              imagePath: Assets.svgIcons.editIc,
                              height: 20.w,
                              width: 20.w,
                            ),
                            Text(
                              context.l10n.createACustomPrompt,
                              style:
                                  AppTextStyle.s18w600(
                                    color: AppColors.primaryColor,
                                  ).copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: AppColors.primaryColor,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      CustomImageView(
                        imagePath: Assets.svgIcons.aiStarIc2,
                        height: 20.w,
                        width: 20.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildPromptItem(
    BuildContext context,
    PromptModel prompt,
    bool isSelected,
    PromptsCubit cubit,
    PromptsState state,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
        ),
        borderRadius: 12.radius,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => cubit.togglePrompt(prompt),
            child: Container(
              color: AppColors.transparent,
              padding: 16.allPad.copyWith(bottom: isSelected ? 0 : 16.h),
              child: Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: Text(
                      prompt.question ?? '',
                      style: AppTextStyle.s14w400(
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ),
                  CustomImageView(imagePath: Assets.svgIcons.arrowDownBigIc),
                ],
              ),
            ),
          ),
          if (isSelected)
            Padding(
              padding: 16.allPad,
              child: AppTextField(
                controller: state.selectedPrompts[prompt.question],
                hintLabel: 'Type your answer...',
                textInputAction: .newline,
                keyboardType: .multiline,
                maxLength: 220,
                maxLines: 4,
                bottomPad: 0,
              ),
            ),
        ],
      ),
    );
  }
}
