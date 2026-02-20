import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ryann_dating/l10n/app_localizations.dart';

extension Context on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  double get bottomPad {
    final bottom = MediaQuery.paddingOf(this).bottom;
    return bottom / (Platform.isIOS ? 2 : 1) + (bottom < 5 ? 15 : 10);
  }

  double get topPad => MediaQuery.paddingOf(this).top;

  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
