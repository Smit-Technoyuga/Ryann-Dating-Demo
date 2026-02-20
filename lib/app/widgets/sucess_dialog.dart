import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/common_btn.dart';

void showSucessDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  String? description,
  required String btnText,
  Function()? onTap,
  String? btn2Text,
  Color? txtColor,
  Color? titleColor,
  TextStyle? titleStyle,
  Function()? onTap2,
}) {
  showDialog(
    context: context,
    builder: (context) => _RegisterDialog(
      title: title,
      subTitle: subTitle,
      btnText: btnText,
      onTap: onTap,
      description: description,
      btn2Text: btn2Text,
      onTap2: onTap2,
      txtColor: txtColor,
      titleColor: titleColor,
      titleStyle: titleStyle,
    ),
  );
}

class _RegisterDialog extends StatelessWidget {
  const _RegisterDialog({
    required this.title,
    required this.subTitle,
    required this.btnText,
    this.description,
    this.onTap,
    this.btn2Text,
    this.onTap2,
    this.txtColor,
    this.titleColor,
    this.titleStyle,
  });
  final String title;
  final String subTitle;
  final String btnText;
  final String? btn2Text;
  final String? description;
  final Color? txtColor;
  final Color? titleColor;
  final TextStyle? titleStyle;
  final Function()? onTap;
  final Function()? onTap2;

  @override
  Widget build(BuildContext context) {
    final isDescription = description?.isNotEmpty ?? false;
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.r),
      ),
      insetPadding: .zero,
      constraints: BoxConstraints(maxWidth: 350.w),
      child: Padding(
        padding: 24.allPad,
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              title,
              textAlign: .center,
              style:
                  titleStyle ??
                  AppTextStyle.s16w600(
                    color: titleColor ?? AppColors.primaryColor,
                  ),
            ),
            Padding(
              padding: (isDescription ? 8 : 16).topPad.add(
                isDescription ? 8.btmPad : 32.btmPad,
              ),
              child: Text(
                subTitle,
                textAlign: .center,
                style: AppTextStyle.s14w400(
                  color: txtColor ?? AppColors.textPrimaryColor,
                ),
              ),
            ),
            if (isDescription)
              Padding(
                padding: 24.btmPad,
                child: Text(
                  description ?? '',
                  textAlign: .center,
                  style: AppTextStyle.s14w400(
                    color: txtColor ?? AppColors.textPrimaryColor,
                  ),
                ),
              ),
            Row(
              spacing: 12.w,
              children: [
                if (btn2Text != null)
                  Expanded(
                    child: CommonBtn(
                      title: btn2Text!,
                      vertPad: 11.dg,
                      btnColor: AppColors.whiteColor,
                      txtStyle: AppTextStyle.s12w500(
                        color: AppColors.primaryColor,
                      ),
                      onTap: () => onTap2?.call(),
                    ),
                  ),
                Expanded(
                  child: CommonBtn(
                    title: btnText,
                    vertPad: 11.dg,
                    txtStyle: AppTextStyle.s12w500(),
                    onTap: () => onTap?.call(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
