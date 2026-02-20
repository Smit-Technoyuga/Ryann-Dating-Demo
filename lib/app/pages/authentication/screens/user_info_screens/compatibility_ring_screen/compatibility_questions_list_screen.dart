import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/compatibility_ring_screen.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/cubit/compatibility_questions_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/compatibility_ring_screen/cubit/compatibility_questions_state.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/app/widgets/custom_radio_btn.dart';
import 'package:ryann_dating/app/widgets/shimmer_widgets/question_shimmer.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class CompatibilityQuestionsListScreen extends StatelessWidget {
  const CompatibilityQuestionsListScreen({super.key, this.args});

  final CompatibilityRingScreenArgs? args;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlocProvider(
        create: (context) => CompatibilityQuestionsCubit(
          answeredCount: args?.answeredQue,
          initialAnswers: args?.compatibilityAnswers,
        )..getQuestions(),
        child: BlocBuilder<CompatibilityQuestionsCubit, CompatibilityQuestionsState>(
          builder: (context, state) {
            final hasLoadNEmpty = state.isLoading || state.questions.isEmpty;

            final currentQuestion = hasLoadNEmpty
                ? null
                : state.questions[state.currentStep];
            final selectedOption = hasLoadNEmpty
                ? null
                : state.answers[state.currentStep];

            final isMultiSelect = currentQuestion?.answerType == .MULTI_SELECT;

            return Scaffold(
              bottomNavigationBar: state.isLoading
                  ? null
                  : Padding(
                      padding: context.bottomPad.btmPad
                          .add(24.horPad)
                          .add(10.topPad),
                      child: Column(
                        mainAxisSize: .min,
                        spacing: 12.h,
                        children: [
                          CommonBtn(
                            title: context.l10n.saveAndComeBackLater,
                            btnColor: AppColors.transparent,
                            borderColor: AppColors.primaryColor,
                            isDisabled: selectedOption == null,
                            txtColor: AppColors.primaryColor,
                            onTap: () {
                              context
                                  .read<CompatibilityQuestionsCubit>()
                                  .saveAndExit(context, () {});
                            },
                          ),
                          CommonBtn(
                            title: context.l10n.continues,
                            isDisabled: selectedOption == null,
                            onTap: () => context
                                .read<CompatibilityQuestionsCubit>()
                                .nextStep(context, () {}),
                          ),
                        ],
                      ),
                    ),
              body: Padding(
                padding: (context.topPad + 8).topPad,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    // Top Progress Bar
                    Padding(
                      padding: 24.horPad,
                      child: Row(
                        spacing: 12.w,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: 10.radius,
                              child: LinearProgressIndicator(
                                value: hasLoadNEmpty
                                    ? 0
                                    : (state.currentStep) /
                                          state.questions.length,
                                backgroundColor: AppColors.borderColor
                                    .withValues(alpha: 0.3),
                                color: AppColors.primaryColor,
                                minHeight: 6.h,
                              ),
                            ),
                          ),
                          Text(
                            hasLoadNEmpty
                                ? '0%'
                                : '${((state.currentStep) / state.questions.length * 100).toInt()}%',
                            style: AppTextStyle.s14w400(
                              color: AppColors.textGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Back Button
                    Padding(
                      padding: 24.leftPad.add(8.vertPad),
                      child: InkWell(
                        onTap: () {
                          if (state.currentStep > 0) {
                            context
                                .read<CompatibilityQuestionsCubit>()
                                .previousStep();
                          } else {
                            context.pop();
                          }
                        },
                        child: CustomImageView(
                          imagePath: Assets.svgIcons.backArrow,
                        ),
                      ),
                    ),
                    if (!state.isLoading && state.questions.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(context.l10n.noQuestionFound),
                        ),
                      )
                    else
                      Expanded(
                        child: state.isLoading
                            ? const QuestionShimmer()
                            : ListView(
                                padding: 24.horPad.add(18.vertPad),
                                children: [
                                  Text(
                                    currentQuestion?.category ?? '',
                                    style: AppTextStyle.s22w500(),
                                  ),
                                  Padding(
                                    padding: (isMultiSelect ? 8 : 24).topPad
                                        .add((isMultiSelect ? 16 : 8).btmPad),
                                    child: Text(
                                      currentQuestion?.title ?? '',
                                      style: isMultiSelect
                                          ? AppTextStyle.s14w400(
                                              color: AppColors.textPrimaryColor,
                                            )
                                          : AppTextStyle.s16w500(),
                                    ),
                                  ),
                                  ...currentQuestion?.options?.map((option) {
                                        final isSelected = isMultiSelect
                                            ? (selectedOption?.contains(
                                                    option.value ?? '',
                                                  ) ??
                                                  false)
                                            : selectedOption == option.value;
                                        final isMaxSelected =
                                            isMultiSelect &&
                                            context
                                                .read<
                                                  CompatibilityQuestionsCubit
                                                >()
                                                .is3AnswerSelected();
                                        return InkWell(
                                          onTap: () => isMultiSelect
                                              ? context
                                                    .read<
                                                      CompatibilityQuestionsCubit
                                                    >()
                                                    .selectMultipleOptions(
                                                      option.value ?? '',
                                                    )
                                              : context
                                                    .read<
                                                      CompatibilityQuestionsCubit
                                                    >()
                                                    .selectOption(
                                                      option.value ?? '',
                                                    ),
                                          child: Container(
                                            padding: 8.vertPad,
                                            color: AppColors.transparent,
                                            child: Row(
                                              spacing: 16.w,
                                              children: [
                                                if (isMultiSelect)
                                                  CustomCheckBox(
                                                    isSelected: isSelected,
                                                    isMaxSelected:
                                                        isMaxSelected,
                                                  )
                                                else
                                                  CustomRadioBtn(
                                                    isSelected: isSelected,
                                                  ),
                                                Expanded(
                                                  child: Text(
                                                    option.label ?? '',
                                                    style: AppTextStyle.s14w400(
                                                      color: isSelected
                                                          ? AppColors
                                                                .primaryColor
                                                          : isMaxSelected
                                                          ? AppColors
                                                                .color838383
                                                          : AppColors
                                                                .textPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }) ??
                                      [],
                                ],
                              ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
