import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryann_dating/app/utils/extensions/double_ext.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';
import 'package:ryann_dating/app/utils/theme/text_style.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hintLabel,
    this.title,
    this.titleStyle,
    this.type,
    this.autovalidateMode = AutovalidateMode.onUnfocus,
    this.validator,
    this.enabled,
    this.readOnly,
    this.expands,
    this.obscuringCharacter,
    this.obscureText,
    this.keyboardType,
    this.autoFillHints,
    this.suffixIcon,
    this.prefixIcon,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.bottomPad,
    this.spacing,
    this.contentPadding,
    this.fillColor,
    this.isDense,
    this.hintColor,
    this.onChanged,
    this.onTap,
    this.borderColor,
    this.maxLength,
    this.textCapitalization,
    this.onFieldSubmitted,
  });
  final InputType? type;
  final TextEditingController? controller;
  final String? title;
  final TextStyle? titleStyle;
  final String? hintLabel;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? readOnly;
  final bool? enabled;
  final bool? expands;
  final int? maxLines;
  final int? minLines;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final Iterable<String>? autoFillHints;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? bottomPad;
  final double? spacing;
  final Color? fillColor;
  final Color? hintColor;
  final Color? borderColor;
  final bool? isDense;
  final EdgeInsets? contentPadding;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: spacing ?? 5.h,
      children: [
        if (title != null)
          Text(title!, style: titleStyle ?? AppTextStyle.s14w500()),
        Padding(
          padding: (bottomPad ?? 16).btmPad,
          child: TextInputField(
            controller: controller,
            type: type ?? InputType.text,
            hintLabel: hintLabel,
            autoFillHints: autoFillHints,
            autovalidateMode: autovalidateMode,
            enabled: enabled,
            expands: expands ?? false,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            onChanged: onChanged,
            key: key,
            maxLength: maxLength,
            maxLines: maxLines,
            minLines: minLines,
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter ?? '*',
            prefixIcon: prefixIcon,
            readOnly: readOnly ?? false,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding,
            textInputAction: textInputAction,
            validator: validator,
            fillColor: fillColor,
            isDense: isDense,
            hintColor: hintColor,
            onTap: onTap,
            onFieldSubmitted: onFieldSubmitted,
            borderColor: borderColor,
            textCapitalization:
                textCapitalization ??
                (type == InputType.email || type == InputType.password
                    ? TextCapitalization.none
                    : TextCapitalization.sentences),
          ),
        ),
      ],
    );
  }
}

class TextInputField extends TextFormField {
  TextInputField({
    super.key,
    required InputType type,
    super.controller,
    String? hintLabel,
    super.textInputAction = TextInputAction.next,
    super.maxLines,
    super.minLines,
    super.autovalidateMode = AutovalidateMode.onUnfocus,
    super.validator,
    super.enabled,
    super.readOnly,
    super.onTap,
    super.expands,
    super.onChanged,
    super.onFieldSubmitted,
    super.textCapitalization,
    bool? obscureText,
    bool? isDense,
    super.obscuringCharacter,
    TextInputType? keyboardType,
    Iterable<String>? autoFillHints,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color? fillColor,
    Color? borderColor,
    Color? hintColor,
    super.maxLength,
    EdgeInsets? contentPadding,
    List<TextInputFormatter>? inputFormatters,
  }) : assert(
         type != InputType.multiline ||
             textInputAction == TextInputAction.newline,
         'Make textInputAction = TextInputAction.newline',
       ),
       assert(
         (type != InputType.password &&
                 type != InputType.newPassword &&
                 type != InputType.confirmPassword) ||
             obscureText != null,
         'Make sure your providing obscureText and Wrap Obx on TextInputField',
       ),
       super(
         keyboardType:
             keyboardType ??
             switch (type) {
               InputType.name => TextInputType.name,
               InputType.text => TextInputType.text,
               InputType.email => TextInputType.emailAddress,
               InputType.password => TextInputType.visiblePassword,
               InputType.confirmPassword => TextInputType.visiblePassword,
               InputType.newPassword => TextInputType.visiblePassword,
               InputType.phoneNumber => TextInputType.phone,
               InputType.digits => TextInputType.number,
               InputType.decimalDigits => const TextInputType.numberWithOptions(
                 decimal: true,
               ),
               InputType.multiline => TextInputType.multiline,
             },
         autofillHints: [
           if (autoFillHints != null) ...autoFillHints,
           switch (type) {
             InputType.name => AutofillHints.name,
             InputType.email => AutofillHints.email,
             InputType.password => AutofillHints.password,
             InputType.confirmPassword => AutofillHints.password,
             InputType.newPassword => AutofillHints.newPassword,
            InputType.phoneNumber => AutofillHints.telephoneNumber,
             _ => '',
           },
         ],
         inputFormatters: [
           if (inputFormatters != null) ...inputFormatters,
           if (type == InputType.digits || type == InputType.phoneNumber)
             FilteringTextInputFormatter.digitsOnly,
           if (type == InputType.decimalDigits)
             FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
         ],
         obscureText: obscureText ?? false,
         style: AppTextStyle.s14w400(color: AppColors.textPrimaryColor),
         cursorColor: AppColors.textPrimaryColor,
         onTapOutside: (event) {
           FocusManager.instance.primaryFocus?.unfocus();
         },
         decoration: InputDecoration(
           hintText: hintLabel,
           fillColor: fillColor,
           counter: const SizedBox.shrink(),
           filled: fillColor != null,
           isDense: isDense,
           contentPadding: contentPadding ?? 14.allPad,
           hintStyle: AppTextStyle.s14w400(color: hintColor),
           prefixIcon: prefixIcon,
           suffixIcon: suffixIcon,
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10.r),
             borderSide: BorderSide(
               color: borderColor ?? fillColor ?? AppColors.borderColor,
             ),
           ),
           enabledBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10.r),
             borderSide: BorderSide(
               color: borderColor ?? fillColor ?? AppColors.borderColor,
             ),
           ),
           focusedBorder: OutlineInputBorder(
             borderRadius: BorderRadius.circular(10.r),
             borderSide: BorderSide(
               color: borderColor ?? fillColor ?? AppColors.textPrimaryColor,
             ),
           ),
         ),
       );
}

enum InputType {
  name,
  text,
  email,
  password,
  confirmPassword,
  newPassword,
  phoneNumber,
  digits,
  decimalDigits,
  multiline,
}
