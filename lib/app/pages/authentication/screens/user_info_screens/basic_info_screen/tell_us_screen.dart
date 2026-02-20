import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';

import 'package:ryann_dating/app/routes/app_routes.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/helper/validator.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_form_filed.dart';
import 'package:ryann_dating/app/widgets/custom_textfields.dart';

class TellUsScreen extends StatelessWidget {
  const TellUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BasicInfoCubit(),
      child: BlocBuilder<BasicInfoCubit, BasicInfoState>(
        builder: (context, state) {
          return Form(
            child: CommonAuthScreen(
              header: context.l10n.tellUsAboutYou,
              btmWidget: Builder(
                builder: (context) {
                  return CommonBtn(
                    title: context.l10n.next,
                    onTap: () {
                      if (Form.of(context).validate()) {
                        context.push(
                          AppRoutes.dob,
                          extra: context.read<BasicInfoCubit>(),
                        );
                      }
                    },
                  );
                },
              ),
              children: [
                Padding(
                  padding: 32.topPad,
                  child: AppTextField(
                    title: context.l10n.firstName,
                    textInputAction: TextInputAction.done,
                    controller: state.nameController,
                    hintLabel: context.l10n.enterFirstName,
                    validator: (value) => TextValidator.validate(
                      value,
                      error: context.l10n.pleaseEnterYourName,
                    ),
                  ),
                ),
                Padding(
                  padding: 16.btmPad,
                  child: Text(
                    context.l10n.gender,
                    style: AppTextStyle.s14w500(),
                  ),
                ),
                CustomFormFiled(
                  validator: (value) => TextValidator.validate(
                    state.gender?.toString(),
                    error: context.l10n.pleaseSelectYourGender,
                  ),
                  builder: (field) {
                    return Row(
                      spacing: 16.w,
                      children: Gender.values.map((e) {
                        final isSelected = state.gender == e;
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              field.didChange(e);
                              context.read<BasicInfoCubit>().selectGender(e);
                            },
                            child: Row(
                              spacing: 12.w,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  padding: 3.allPad,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.blackColor
                                          : AppColors.color6C757D,
                                      width: 1.2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const CircleAvatar(
                                          backgroundColor: AppColors.blackColor,
                                        )
                                      : null,
                                ),
                                Text(
                                  e.name,
                                  style: AppTextStyle.s14w500(
                                    color: AppColors.textPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                Text(
                  context.l10n.genderHelpText,
                  style: AppTextStyle.s12w400(color: AppColors.textLightColor),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
