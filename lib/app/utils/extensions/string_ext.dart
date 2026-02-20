import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ryann_dating/app/utils/theme/app_colors.dart';

extension StringExt on String {
  void get errorToast => Fluttertoast.showToast(
    msg: this,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: AppColors.whiteColor,
    fontSize: 16,
  );
  void get successToast => Fluttertoast.showToast(
    msg: this,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
    textColor: AppColors.whiteColor,
    fontSize: 16,
  );
}
