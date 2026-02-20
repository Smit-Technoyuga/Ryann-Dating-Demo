// Email Validator`
import 'package:flutter/material.dart';
import 'package:ryann_dating/app/utils/extensions/context_ext.dart';

class EmailValidator {
  // Simple email validation
  static String? validate(String? value, BuildContext context) {
    if (value == null || value.trim().isEmpty) {
      return context.l10n.pleaseEnterYourEmail;
    }

    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return context.l10n.pleaseEnterValidEmail;
    }

    return null;
  }
}

// Empty Text Validator
class TextValidator {
  // Simple empty check
  static String? validate(String? value, {String? error}) {
    if (value == null || value.trim().isEmpty) {
      return error;
    }
    return null;
  }

  // With minimum length
  static String? validateWithLength(
    String? value, {
    required int minLength,
    String? fieldName,
    String? error,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (value.trim().length < minLength) {
      return '${fieldName ?? 'This field'} must be at least $minLength characters';
    }

    return null;
  }

  // With minimum length
  static String? dobValidation(String? value, BuildContext context) {
    if ((value?.length ?? 0) < 8) return null;
    final dob = DateTime(
      int.parse(value!.substring(4, 8)),
      int.parse(value.substring(2, 4)),
      int.parse(value.substring(0, 2)),
    );
    if (!isValidDate(value)) {
      return context.l10n.pleaseEnterValidDate;
    }
    if (!is18OrOlder(dob)) {
      return context.l10n.youMustBeAtLeast18YearsOld;
    }

    return null;
  }

  static bool is18OrOlder(DateTime dob) {
    final today = DateTime.now();

    var age = today.year - dob.year;

    // If birthday has not occurred yet this year → age -1
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }

    return age >= 18;
  }

  static bool isValidDate(String dob) {
    if (dob.length != 8) return false;

    final day = int.tryParse(dob.substring(0, 2));
    final month = int.tryParse(dob.substring(2, 4));
    final year = int.tryParse(dob.substring(4, 8));

    if (day == null || month == null || year == null) return false;

    // Basic range check
    if (month < 1 || month > 12) return false;
    if (day < 1 || day > 31) return false;
    if (year < 1900 || year > DateTime.now().year) return false;

    // Actual calendar validation
    final date = DateTime(year, month, day);

    return date.day == day && date.month == month && date.year == year;
  }

  // With min and max length
  static String? validateWithMinMax(
    String? value, {
    required int minLength,
    required int maxLength,
    String? fieldName,
  }) {
    final field = fieldName ?? 'This field';

    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }

    if (value.trim().length < minLength) {
      return '$field must be at least $minLength characters';
    }

    if (value.trim().length > maxLength) {
      return '$field must not exceed $maxLength characters';
    }

    return null;
  }
}

// Phone Number Validator
class PhoneValidator {
  // Simple phone validation (10 digits)
  static String? validate(String? value, [int? length, Function()? onTap]) {
    if (value == null || value.trim().isEmpty) {
      onTap?.call();
      return 'Phone number is required';
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length != (length ?? 10)) {
      onTap?.call();
      return 'Please enter a valid ${length ?? 10}-digit phone number';
    }

    return null;
  }
}

// Otp Validator
class OtpValidator {
  // Simple otp validation (6 digits)
  static String? validate(String? value, [int? length]) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter Otp';
    }

    if (value.length != (length ?? 6)) {
      return 'Please enter ${length ?? 6}-digit otp';
    }

    return null;
  }
}

// Password Validator
class PasswordValidator {
  // Simple password validation
  static String? validate(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    return null;
  }

  // Strong password validation
  static String? validateStrong(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp('[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp('[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!value.contains(RegExp('[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }
}
