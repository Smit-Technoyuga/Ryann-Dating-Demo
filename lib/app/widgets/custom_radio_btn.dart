import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';

class CustomRadioBtn extends StatelessWidget {
  const CustomRadioBtn({super.key, required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.w,
      width: 20.w,
      child: Container(
        margin: 1.5.allPad,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? AppColors.textPrimaryColor
                : AppColors.color6C757D,
            width: 1.5,
          ),
        ),
        child: Icon(
          Icons.circle,
          color: isSelected
              ? AppColors.textPrimaryColor
              : AppColors.transparent,
          size: 8,
        ),
      ),
    );
  }
}

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    super.key,
    required this.isSelected,
    this.isMaxSelected = false,
  });
  final bool isSelected;
  final bool isMaxSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20.w,
      width: 20.w,
      child: Container(
        margin: 1.allPad,
        decoration: BoxDecoration(
          borderRadius: 1.33.radius,
          border: Border.all(
            color: isMaxSelected && !isSelected
                ? AppColors.color838383
                : isSelected
                ? AppColors.primaryColor
                : AppColors.textGreyColor,
            width: 1.5,
          ),
          color: isSelected ? AppColors.primaryColor : AppColors.transparent,
        ),
        child: Icon(
          Icons.check_sharp,
          color: isSelected ? AppColors.whiteColor : AppColors.transparent,
          size: 14,
        ),
      ),
    );
  }
}
