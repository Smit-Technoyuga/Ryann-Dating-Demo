import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';

class StatusBarTheme {
  static final whitePrimary = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Platform.isIOS ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: AppColors.darkPrimary,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static final whiteWhite = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Platform.isIOS ? Brightness.dark : Brightness.light,
    systemNavigationBarColor: AppColors.whiteColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: AppColors.whiteColor,
  );

  static final darkWhite = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
    statusBarColor: AppColors.whiteColor,
    systemNavigationBarColor: AppColors.whiteColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static final welcomeScreen = SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
    statusBarColor: AppColors.primaryColor,
    systemNavigationBarColor: AppColors.primaryColor,
    systemNavigationBarIconBrightness: Brightness.light,
  );
}
