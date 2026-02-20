import 'package:flutter/material.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';

class CustomFormFiled<T> extends StatelessWidget {
  const CustomFormFiled({
    super.key,
    this.validator,
    required this.builder,
    this.btmPad,
    this.topPad,
    this.value,
    this.error,
  });
  final String? Function(T?)? validator;
  final Widget Function(FormFieldState<dynamic> field) builder;
  final double? btmPad;
  final double? topPad;
  final T? value;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator:
          validator ??
          (v) {
            if (value == null) {
              return error;
            }
            return null;
          },
      initialValue: value,
      builder: (FormFieldState<T> field) {
        return Column(
          crossAxisAlignment: .start,
          children: [
            builder(field),
            if (field.hasError) ...[
              Padding(
                padding: 20.leftPad
                    .add((topPad ?? 4).topPad)
                    .add((btmPad ?? 16).btmPad),
                child: Text(
                  field.errorText ?? '',
                  style: AppTextStyle.s12w400(color: AppColors.errorColor),
                ),
              ),
            ] else ...[
              Padding(padding: (btmPad ?? 16).btmPad),
            ],
          ],
        );
      },
    );
  }
}
