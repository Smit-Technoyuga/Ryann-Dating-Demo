import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/cubit/profile_basics_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/profile_basics_screen/cubit/profile_basics_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

class ReviewDetailsScreen extends StatelessWidget {
  const ReviewDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBasicsCubit, ProfileBasicsState>(
      builder: (context, state) {
        return CommonAuthScreen(
          header: context.l10n.reviewYourDetails,
          subText: context.l10n.confirmBasicDetailsCorrect,
          subTextTopPad: 8.h,
          btmWidget: Column(
            mainAxisSize: .min,
            spacing: 12.h,
            children: [
              CommonBtn(
                title: context.l10n.editDetails,
                onTap: context.pop,
                btnColor: AppColors.whiteColor,
                txtColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
              ),
              CommonBtn(
                title: context.l10n.confirmAndContinue,
                isLoading: state.isLoading,
                onTap: () =>
                    context.read<ProfileBasicsCubit>().savePreferences(context),
              ),
            ],
          ),
          children: [
            Padding(
              padding: 24.topPad,
              child: Column(
                children: [
                  _DetailRow(
                    label: context.l10n.interestedIn,
                    value: state.interestedIn == InterestedIn.men
                        ? context.l10n.men
                        : state.interestedIn == InterestedIn.women
                        ? context.l10n.women
                        : context.l10n.everyone,
                  ),
                  _DetailRow(
                    label: context.l10n.location,
                    value: state.locationController.text.isEmpty
                        ? '-'
                        : state.locationController.text,
                  ),
                  _DetailRow(
                    label: context.l10n.age,
                    value:
                        '${state.ageRange.start.toInt()} - ${state.ageRange.end.toInt()}',
                  ),
                  _DetailRow(
                    label: context.l10n.matchDistance,
                    value: '${state.matchDistance.toInt()} km',
                  ),
                  _DetailRow(
                    label: context.l10n.height,
                    value: state.height ?? '-',
                  ),
                  _DetailRow(
                    label: context.l10n.occupation,
                    value: state.occupation ?? '-',
                  ),
                  _DetailRow(
                    label: context.l10n.education,
                    value: state.education ?? '-',
                  ),
                  _DetailRow(
                    label: context.l10n.religion,
                    value: state.religion ?? '-',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 20.btmPad,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.s14w400(color: AppColors.color525252),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
