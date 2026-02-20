import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/validator.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/sucess_dialog.dart';

class DobScreen extends StatelessWidget {
  const DobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hints = ['D', 'D', 'M', 'M', 'Y', 'Y', 'Y', 'Y'];
    return Form(
      child: CommonAuthScreen(
        header: context.l10n.whatsYourDob,
        subText: context.l10n.dobUsageInfo,
        btmWidget: BlocBuilder<BasicInfoCubit, BasicInfoState>(
          builder: (context, state) {
            return CommonBtn(
              title: context.l10n.next,
              isLoading: state.isLoading,
              isDisabled: (state.dobText.length) < 8,
              onTap: () {
                for (final node in state.dobFocusNodes) {
                  node.unfocus();
                }
                if (Form.of(context).validate()) {
                  final dob = context.read<BasicInfoCubit>().getDob();

                  showSucessDialog(
                    context,
                    title:
                        '${context.l10n.youAre} ${DateTime.now().difference(dob!).inDays ~/ 365}',
                    description: context.l10n.correct,
                    subTitle:
                        "${context.l10n.born} ${DateFormat('MMMM dd, yyyy').format(dob)}",
                    btnText: context.l10n.confirm,
                    btn2Text: context.l10n.edit,
                    txtColor: AppColors.textLightColor,
                    titleColor: AppColors.textPrimaryColor,
                    onTap2: context.pop,
                    onTap: () =>
                        context.read<BasicInfoCubit>().saveBasicInfo(context),
                  );
                }
              },
            );
          },
        ),
        children: [
          BlocBuilder<BasicInfoCubit, BasicInfoState>(
            builder: (context, state) {
              return Padding(
                padding: 32.vertPad,
                child: FormField<String>(
                  initialValue: state.dobText,
                  validator: (value) =>
                      TextValidator.dobValidation(state.dobText, context),
                  builder: (formState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(8, (index) {
                            return Expanded(
                              child: _DigitBox(
                                controller: state.dobControllers[index],
                                focusNode: state.dobFocusNodes[index],
                                hint: hints[index],
                                hasError: formState.hasError,
                                onChanged: (value) {
                                  formState.didChange(state.dobText);
                                  context
                                      .read<BasicInfoCubit>()
                                      .updateDobText();
                                  if (value.isNotEmpty && index < 7) {
                                    state.dobFocusNodes[index + 1]
                                        .requestFocus();
                                  }
                                },
                                onBackspace: () {
                                  if (index > 0) {
                                    state.dobFocusNodes[index - 1]
                                        .requestFocus();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        if (formState.hasError)
                          Padding(
                            padding: 8.topPad + 4.horPad,
                            child: Text(
                              formState.errorText!,
                              style: AppTextStyle.s12w400(
                                color: AppColors.errorColor,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DigitBox extends StatelessWidget {
  const _DigitBox({
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.onChanged,
    required this.onBackspace,
    this.hasError = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback onBackspace;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            controller.text.isEmpty) {
          onBackspace();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: AppTextStyle.s14w500(),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onTap: () {
          if (controller.text.isNotEmpty) {
            controller.selection = TextSelection(
              baseOffset: 0,
              extentOffset: controller.text.length,
            );
          }
        },
        decoration: InputDecoration(
          counterText: '',
          hintText: hint,
          hintStyle: AppTextStyle.s14w400(color: AppColors.textHintColor),
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: hasError ? AppColors.errorColor : AppColors.otpBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: hasError ? AppColors.errorColor : AppColors.primaryColor,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
