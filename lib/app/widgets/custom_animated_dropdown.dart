import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';
import 'package:ryann_dating/app/widgets/custom_form_filed.dart';
import 'package:ryann_dating/app/widgets/custom_image_view.dart';
import 'package:ryann_dating/gen/assets.gen.dart';

class CustomAnimatedDropdown extends StatefulWidget {
  const CustomAnimatedDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.items,
    this.value,
    this.error,
    required this.onChanged,
  });

  final String title;
  final String hint;
  final List<String> items;
  final String? value;
  final String? error;
  final ValueChanged<String?> onChanged;

  @override
  State<CustomAnimatedDropdown> createState() => _CustomAnimatedDropdownState();
}

class _CustomAnimatedDropdownState extends State<CustomAnimatedDropdown>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          widget.title,
          style: AppTextStyle.s12w500(color: AppColors.textPrimaryColor),
        ),
        Padding(
          padding: 8.topPad.add(16.btmPad),
          child: CustomFormFiled(
            value: widget.value,
            error: widget.error,
            btmPad: 0,
            builder: (filed) {
              return Column(
                children: [
                  InkWell(
                    onTap: _handleTap,
                    borderRadius: 10.radius,
                    child: Container(
                      padding: 14.allPad,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: 10.radius,
                        border: Border.all(
                          color: filed.hasError
                              ? AppColors.errorColor
                              : AppColors.borderColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.value ?? widget.hint,
                              style: AppTextStyle.s14w400(
                                color: widget.value == null
                                    ? AppColors.textHintColor
                                    : AppColors.textPrimaryColor,
                              ),
                            ),
                          ),
                          CustomImageView(
                            imagePath: Assets.svgIcons.arrowDownBigIc,
                            height: 16.w,
                            width: 16.w,
                            color: AppColors.textPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRect(
                    child: AnimatedBuilder(
                      animation: _controller.view,
                      builder: (context, child) {
                        return Align(
                          alignment: Alignment.topCenter,
                          heightFactor: _heightFactor.value,
                          child: child,
                        );
                      },
                      child: Container(
                        margin: 5.topPad,
                        constraints: BoxConstraints(maxHeight: 250.h),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: 10.radius,
                          border: .all(color: AppColors.borderColor),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: 8.vertPad,
                          itemCount: widget.items.length,
                          itemBuilder: (context, index) {
                            final item = widget.items[index];
                            final isSelected = item == widget.value;
                            return GestureDetector(
                              onTap: () {
                                widget.onChanged(item);
                                _handleTap();
                              },
                              child: Container(
                                color: AppColors.transparent,
                                padding: 14.horPad.add(8.vertPad),
                                child: Text(
                                  item,
                                  style: AppTextStyle.s14w400(
                                    color: isSelected
                                        ? AppColors.primaryColor
                                        : AppColors.textPrimaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
