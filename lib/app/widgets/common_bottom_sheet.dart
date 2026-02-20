import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet({
    super.key,
    required this.title,
    this.topWidget,
    required this.bottomWidget,
  });
  final String title;
  final Widget? topWidget;
  final Widget bottomWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: context.height * .9),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: 32.topPad.add(
        (context.bottomPad + MediaQuery.viewInsetsOf(context).bottom).btmPad,
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: 24.horPad,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                InkWell(
                  onTap: () => context.pop(),
                  child: CustomImageView(imagePath: Assets.svgIcons.backArrow),
                ),
                Padding(
                  padding: 16.topPad.add(12.btmPad),
                  child: Text(title, style: AppTextStyle.s22w500()),
                ),
                ?topWidget,
              ],
            ),
          ),
          Divider(height: 24.h),
          Flexible(child: bottomWidget),
        ],
      ),
    );
  }
}
