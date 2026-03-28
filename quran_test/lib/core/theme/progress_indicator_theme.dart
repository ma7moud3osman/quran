import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';

ProgressIndicatorThemeData getProgressIndicatorTheme({required bool isDark}) {
  return ProgressIndicatorThemeData(
    color: Colors.white,
    refreshBackgroundColor: isDark ? AppColorsDark.primary : AppColors.primary,
  );
}
