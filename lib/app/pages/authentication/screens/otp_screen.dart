import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/validator.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpTimerCubit()..startTime(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              context.read<OtpTimerCubit>().stopTime();
            },
            child: Form(
              child: CommonAuthScreen(
                header: context.l10n.verifyYourNumber,
                subText: context.l10n.enterSixDigitCode,
                btmWidget: ValueListenableBuilder(
                  valueListenable: authState.otpController,
                  builder: (context, value, child) {
                    return CommonBtn(
                      title: context.l10n.next,
                      isDisabled:
                          value.text.length < 6 || authState.isReSendOtpLoad,
                      isLoading: authState.isVerifyOtpLoad,
                      onTap: () {
                        authState.focusNode.unfocus();
                        if (Form.of(context).validate()) {
                          context.read<AuthCubit>().verifyOtp(context);
                        }
                      },
                    );
                  },
                ),
                children: [
                  BlocBuilder<OtpTimerCubit, OtpTimerState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          Padding(
                            padding: 32.vertPad,
                            child: Pinput(
                              autofocus: true,
                              focusNode: authState.focusNode,
                              validator: OtpValidator.validate,
                              errorTextStyle: AppTextStyle.s12w400(
                                color: AppColors.errorColor,
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: authState.otpController,
                              length: 6,
                              errorPinTheme: PinTheme(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.errorColor,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              onCompleted: (value) {
                                authState.focusNode.unfocus();
                                if (Form.of(context).validate()) {
                                  context.read<AuthCubit>().verifyOtp(context);
                                }
                              },
                              defaultPinTheme: PinTheme(
                                width: 48.w,
                                height: 48.w,
                                textStyle: AppTextStyle.s14w500(),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.otpBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 48.w,
                                height: 48.w,
                                textStyle: AppTextStyle.s14w500(),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              submittedPinTheme: PinTheme(
                                width: 48.w,
                                height: 48.w,
                                textStyle: AppTextStyle.s14w500(),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.otpBorderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                            ),
                          ),
                          if (state.time != 0)
                            Padding(
                              padding: 16.btmPad,
                              child: Text(
                                state.time == 60
                                    ? '(01:00)'
                                    : '(00:${state.time > 9 ? state.time : '0${state.time}'})',
                                style: AppTextStyle.s14w400(
                                  color: AppColors.textPrimaryColor,
                                ),
                              ),
                            ),

                          RichText(
                            text: TextSpan(
                              text: context.l10n.didntReceiveCode,
                              style: AppTextStyle.s14w400(
                                color: AppColors.textPrimaryColor,
                              ),
                              children: [
                                TextSpan(
                                  text: ' ${context.l10n.resend}',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      if (state.time != 0 ||
                                          authState.isReSendOtpLoad) {
                                        return;
                                      }

                                      context.read<AuthCubit>().sendOtp(
                                        context,
                                        isResend: true,
                                      );
                                      authState.otpController.clear();
                                    },
                                  style: AppTextStyle.s14w500(
                                    color:
                                        state.time == 0 &&
                                            !authState.isReSendOtpLoad
                                        ? AppColors.primaryColor
                                        : AppColors.textHintColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
