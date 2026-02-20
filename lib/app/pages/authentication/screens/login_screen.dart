import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/cubit/auth_state.dart';
import 'package:ryann_dating/app/pages/authentication/screens/join_wishlist_screen/join_wishlist_screen.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/countries_list.dart';
import 'package:ryann_dating/app/utils/helper/logger.dart';
import 'package:ryann_dating/app/utils/helper/validator.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/country_picker_widget.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    Widget child(AuthState state) => BlocProvider(
      create: (context) => LoginTapCubit(),
      child: BlocBuilder<LoginTapCubit, LoginState>(
        builder: (context, loginState) {
          return Form(
            child: CommonAuthScreen(
              header: isLogin
                  ? context.l10n.phoneNumberVerification
                  : context.l10n.startWithYourNumber,
              subText: context.l10n.otpInfo,
              btmWidget: Builder(
                builder: (context) {
                  return CommonBtn(
                    title: context.l10n.sendCode,
                    isLoading: state.isSendOtpLoad,
                    onTap: () {
                      context.read<LoginTapCubit>().onTap();
                      if (Form.of(context).validate()) {
                        context.read<AuthCubit>().sendOtp(context);
                      }
                    },
                  );
                },
              ),
              children: [
                Builder(
                  builder: (context) {
                    return Padding(
                      padding: 32.topPad.add(isLogin ? 20.btmPad : 32.btmPad),
                      child: AppTextField(
                        bottomPad: 0,
                        type: .phoneNumber,
                        controller: state.phoneController,
                        textInputAction: .done,
                        title: context.l10n.phoneNumber,
                        spacing: 12.h,
                        validator: (value) => PhoneValidator.validate(
                          value,
                          state.phoneCountry?.example.length,
                          () {
                            context.read<LoginTapCubit>().onTap();
                          },
                        ),
                        onChanged: (value) {
                          if (loginState.isTap) {
                            if (Form.of(context).validate()) {
                              'done'.log;
                            }
                          }
                        },
                        prefixIcon: CountryPickerWidget(
                          selectedCountryCode:
                              state.selectedCountry?.countryCode ??
                              state.phoneCountry?.dialCode,
                          countryList: isLogin
                              ? countryCodes
                              : countryCodes
                                    .where(
                                      (e) =>
                                          e.dialCode ==
                                          state.selectedCountry?.countryCode,
                                    )
                                    .toList(),
                          onCountryChange: (country) {
                            context.read<AuthCubit>().selectPhoneCountry(
                              country,
                            );
                            Future.delayed(
                              const Duration(milliseconds: 50),
                              () {
                                Form.of(context).validate();
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                if (isLogin)
                  Padding(
                    padding: 20.btmPad,
                    child: RichText(
                      text: TextSpan(
                        text: '${context.l10n.notInStateOrCountry}\n',
                        style: AppTextStyle.s14w400(
                          color: AppColors.textPrimaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: context.l10n.registerYourInterest,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      const JoinWishlistScreen(),
                                );
                              },
                            style: AppTextStyle.s14w400(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                RichText(
                  text: TextSpan(
                    text: '${context.l10n.verificationMessage} ',
                    style: AppTextStyle.s14w400(
                      color: AppColors.textPrimaryColor,
                    ),
                    children: [
                      TextSpan(
                        text: context.l10n.numberChangeInfo,
                        style: AppTextStyle.s14w600(
                          color: AppColors.textPrimaryColor,
                        ).copyWith(decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    return isLogin
        ? BlocProvider(
            create: (context) => AuthCubit(),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return child(state);
              },
            ),
          )
        : BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return child(state);
            },
          );
  }
}
