import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/validator.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          child: CommonAuthScreen(
            header: context.l10n.registerYourInterest,
            subText: context.l10n.notLiveInAreaMessage,
            btmWidget: Row(
              spacing: 12.w,
              children: [
                Expanded(
                  child: CommonBtn(
                    title: context.l10n.cancel,
                    onTap: context.pop,
                    btnColor: AppColors.transparent,
                    txtColor: AppColors.primaryColor,
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return CommonBtn(
                        title: context.l10n.submit,
                        isLoading: state.isWaitLoad,
                        onTap: () {
                          if (Form.of(context).validate()) {
                            context.read<AuthCubit>().checkWaitingList(context);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: 24.topPad,
                child: AppTextField(
                  hintLabel: context.l10n.enterYourName,
                  controller: state.nameController,
                  title: '${context.l10n.name}*',
                  validator: (String? value) => TextValidator.validate(
                    value,
                    error: context.l10n.pleaseEnterYourName,
                  ),
                ),
              ),
              AppTextField(
                hintLabel: context.l10n.enterYourEmail,
                controller: state.emailController,
                title: '${context.l10n.email}*',
                type: .email,
                validator: (String? value) =>
                    EmailValidator.validate(value, context),
              ),
              AppTextField(
                hintLabel: context.l10n.enterYourCountry,
                controller: state.countryController,
                title: context.l10n.country,
                readOnly: true,
                validator: (String? value) => TextValidator.validate(
                  value,
                  error: context.l10n.pleaseSelectYourCountry,
                ),
              ),
              AppTextField(
                hintLabel: context.l10n.enterYourCity,
                controller: state.cityController,
                title: context.l10n.city,
                readOnly: state.selectedCity != null,
                validator: (String? value) => TextValidator.validate(
                  value,
                  error: context.l10n.pleaseSelectYourCity,
                ),
                textInputAction: .done,
              ),
            ],
          ),
        );
      },
    );
  }
}
