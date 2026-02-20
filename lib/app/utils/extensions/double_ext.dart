import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Double on num {
  EdgeInsets get vertPad => EdgeInsets.symmetric(vertical: toDouble().dg);
  EdgeInsets get horPad => EdgeInsets.symmetric(horizontal: toDouble().dg);
  EdgeInsets get btmPad => EdgeInsets.only(bottom: toDouble().dg);
  EdgeInsets get topPad => EdgeInsets.only(top: toDouble().dg);
  EdgeInsets get leftPad => EdgeInsets.only(left: toDouble().dg);
  EdgeInsets get rightPad => EdgeInsets.only(right: toDouble().dg);
  EdgeInsets get allPad => EdgeInsets.all(toDouble().dg);
  BorderRadius get radius => BorderRadius.circular(toDouble().r);
}
