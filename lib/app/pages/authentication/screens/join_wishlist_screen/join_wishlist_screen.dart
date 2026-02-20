import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/pages/authentication/screens/join_wishlist_screen/cubit/join_wishlist_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/join_wishlist_screen/cubit/join_wishlist_state.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/countries_list.dart';
import 'package:ryann_dating/app/utils/helper/validator.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/widgets/common_bottom_sheet.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/country_picker_widget.dart';
import 'package:ryann_dating/app/widgets/custom_form_filed.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class JoinWishlistScreen extends StatelessWidget {
  const JoinWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => JoinWishlistCubit(),
      child: BlocBuilder<JoinWishlistCubit, JoinWishlistState>(
        builder: (context, state) {
          return PopScope(
            onPopInvokedWithResult: (didPop, result) {
              context.read<JoinWishlistCubit>().cancelRequests();
            },
            child: CommonBottomSheet(
              title: context.l10n.joinTheWaitlist,
              bottomWidget: SingleChildScrollView(
                padding: 16.horPad.add(12.topPad),
                child: Form(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      AppTextField(
                        title: context.l10n.name,
                        controller: state.nameController,
                        hintLabel: context.l10n.enterYourName,
                        validator: (value) => TextValidator.validate(
                          value,
                          error: context.l10n.enterYourName,
                        ),
                      ),
                      AppTextField(
                        title: context.l10n.emailAddress,
                        controller: state.emailController,
                        hintLabel: context.l10n.enterYourEmail,
                        keyboardType: .emailAddress,
                        type: .email,
                        validator: (value) =>
                            EmailValidator.validate(value, context),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(14),
                          child: CustomImageView(
                            imagePath: Assets.svgIcons.email2Ic,
                          ),
                        ),
                      ),
                      CustomFormFiled(
                        topPad: 10.h,
                        validator: (value) => TextValidator.validate(
                          state.selectedCountry?.name,
                          error: context.l10n.pleaseSelectYourCountry,
                        ),
                        builder: (builder) {
                          return AppTextField(
                            bottomPad: 0,
                            title: context.l10n.country,
                            hintLabel: context.l10n.selectCountry,
                            borderColor: builder.errorText?.isNotEmpty ?? false
                                ? AppColors.errorColor
                                : null,
                            controller: TextEditingController(
                              text: state.selectedCountry?.name,
                            ),
                            onTap: () async =>
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      const CountryPickerSheet(),
                                ).then((value) {
                                  if (value != null) {
                                    context
                                        .read<JoinWishlistCubit>()
                                        .selectCountry(value as CountryCode);
                                  }
                                }),
                            readOnly: true,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(14),
                              child: CustomImageView(
                                imagePath: Assets.svgIcons.arrowDownBigIc,
                              ),
                            ),
                          );
                        },
                      ),
                      Builder(
                        builder: (context) {
                          return CommonBtn(
                            title: context.l10n.submit,
                            isLoading: state.isWaitLoad,
                            onTap: () {
                              if (Form.of(context).validate()) {
                                context
                                    .read<JoinWishlistCubit>()
                                    .checkWaitingList(context);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
