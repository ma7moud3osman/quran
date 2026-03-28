import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_language.dart';

extension LanguageExtention on BuildContext {
  bool get isArabic => locale == ARABIC_LOCAL;
  bool get isEnglish => locale == ENGLISH_LOCAL;
}

// Navigation extensions removed in favor of GoRouterExtension
extension MediaQueryExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get topPadding => MediaQuery.of(this).padding.top;
  double get bottomPadding => MediaQuery.of(this).padding.bottom;
}
