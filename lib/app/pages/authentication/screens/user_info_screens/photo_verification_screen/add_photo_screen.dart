import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/cubit/add_photo_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/photo_verification_screen/cubit/add_photo_state.dart';
import 'package:ryann_dating/app/pages/authentication/widgets/common_auth_screen.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class AddPhotoScreen extends StatelessWidget {
  const AddPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPhotoCubit()..init(),
      child: BlocConsumer<AddPhotoCubit, AddPhotoState>(
        listener: (context, state) {
          if (state.isSuccess) {}
        },
        builder: (context, state) {
          final cubit = context.read<AddPhotoCubit>();
          return CommonAuthScreen(
            header: context.l10n.showTheRealYou,
            subText: context.l10n.uploadPhotoInstruction,
            subTextTopPad: 8.h,
            btmWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: 16.btmPad,
                  child: Text(
                    context.l10n.photosVerificationOnly,
                    style: AppTextStyle.s14w400(
                      color: AppColors.textLightColor,
                    ),
                  ),
                ),
                CommonBtn(
                  title: context.l10n.continueToLivenessCheck,
                  isDisabled: state.selectedImages.isEmpty,
                  isLoading: state.isLoading,
                  progress: state.uploadProgress,
                  onTap: () => cubit.uploadPhotos(context),
                ),
              ],
            ),
            children: [
              Padding(
                padding: 8.topPad.add(15.btmPad),
                child: Text(
                  context.l10n.photosNotVisibleYet,
                  style: AppTextStyle.s14w400(color: AppColors.textLightColor),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: 15.allPad,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final hasImage = index < state.selectedImages.length;
                  return GestureDetector(
                    onTap: hasImage ? null : cubit.pickImage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: hasImage
                            ? AppColors.transparent
                            : AppColors.colorF5F5F5,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: hasImage
                          ? Stack(
                              fit: StackFit.expand,
                              children: [
                                ClipRRect(
                                  borderRadius: 15.radius,
                                  child: CustomImageView(
                                    imagePath:
                                        state.selectedImages[index].isNetwork
                                        ? state.selectedImages[index].url
                                        : state
                                              .selectedImages[index]
                                              .file
                                              ?.path,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => cubit.removeImage(index),
                                    child: Container(
                                      height: 28.w,
                                      width: 28.w,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.color171717,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.r),
                                          bottomLeft: Radius.circular(10.r),
                                        ),
                                      ),
                                      child: CustomImageView(
                                        imagePath: Assets.svgIcons.cancelIc,
                                        width: 16.w,
                                        height: 16.w,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: CustomImageView(
                                imagePath: Assets.svgIcons.addIc,
                                width: 32.w,
                                height: 32.h,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
