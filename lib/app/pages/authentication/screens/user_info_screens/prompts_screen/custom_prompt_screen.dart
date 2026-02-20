import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/cubit/prompts_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/prompts_screen/cubit/prompts_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';

class CustomPromptScreen extends StatefulWidget {
  const CustomPromptScreen({super.key});

  @override
  State<CustomPromptScreen> createState() => _CustomPromptScreenState();
}

class _CustomPromptScreenState extends State<CustomPromptScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              onTap: () => context.pop(),
            ),
          ),
          Expanded(
            child: BlocBuilder<PromptsCubit, PromptsState>(
              builder: (context, state) {
                return CommonBtn(
                  title: context.l10n.continues,
                  isLoading: state.isLoading,
                  onTap: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<PromptsCubit>().addCustomPrompt(
                        _controller.text,
                        context,
                      );
                    }
                  },
                );
              }
            ),
          ),
        ],
      ),
      children: [
        Padding(
          padding: 24.topPad,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Padding(
                padding: 24.btmPad,
                child: Text(
                  context.l10n.yourAnswersWillAppearOnYourProfile,
                  style: AppTextStyle.s14w400(color: AppColors.textGreyColor),
                ),
              ),
              AppTextField(
                controller: _controller,
                hintLabel: 'My go-to coffee is...',
                type: .multiline,
                textInputAction: .newline,
                minLines: 4,
                maxLines: 4,
                bottomPad: 8.h,
                maxLength: 200,
              ),
              Align(
                alignment: .centerRight,
                child: ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, controller, child) {
                    return Text(
                      '${controller.text.length}/200',
                      style: AppTextStyle.s12w400(
                        color: AppColors.textGreyColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
