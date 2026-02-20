import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/rotating_loading_icon.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn({
    super.key,
    required this.title,
    this.icon,
    this.radius,
    this.padding,
    this.vertPad,
    this.margin,
    this.btnColor,
    this.txtColor,
    this.borderColor,
    this.txtStyle,
    this.iconSpace,
    this.onTap,
    this.isDisabled = false,
    this.isLoading = false,
    this.progress = 0,
  });

  final String title;
  final Widget? icon;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? vertPad;
  final double? iconSpace;
  final Color? btnColor;
  final Color? txtColor;
  final Color? borderColor;
  final TextStyle? txtStyle;
  final VoidCallback? onTap;
  final bool isDisabled;
  final bool isLoading;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius ?? 50.r),
      onTap: isDisabled || isLoading ? null : onTap,
      child: Container(
        margin: margin,
        height: vertPad != null ? (vertPad! * 2 + 20).h : 48.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: isDisabled || isLoading
              ? AppColors.disableColor
              : btnColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius ?? 50.r),
          border: Border.all(
            color: isDisabled || isLoading
                ? AppColors.disableColor
                : borderColor ?? AppColors.primaryColor,
          ),
        ),
        width: double.infinity,
        child: Stack(
          children: [
            if (progress > 0 && progress < 1)
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  color: AppColors.primaryColor.withValues(alpha: 0.3),
                ),
              ),
            Center(
              child: isLoading
                  ? progress == 0 || progress == 1
                        ? const RotatingLoadingIcon(size: 24)
                        : Text(
                            '${(progress * 100).toInt()}%',
                            style:
                                txtStyle ??
                                AppTextStyle.s16w500(
                                  color: AppColors.textLightColor,
                                ),
                          )
                  : Row(
                      mainAxisAlignment: .center,
                      spacing: iconSpace ?? 10.w,
                      children: [
                        if (icon != null) icon!,
                        Text(
                          title,
                          style:
                              txtStyle ??
                              AppTextStyle.s16w500(
                                color: isDisabled
                                    ? AppColors.textPrimaryColor
                                    : txtColor ?? AppColors.whiteColor,
                              ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
