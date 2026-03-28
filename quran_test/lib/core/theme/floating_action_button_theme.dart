import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';

FloatingActionButtonThemeData getFloatingActionButtonTheme({
  required bool isDark,
  required BuildContext context,
}) {
  return FloatingActionButtonThemeData(
    extendedPadding: EdgeInsets.zero,
    backgroundColor: isDark ? AppColorsDark.primary : AppColors.primary,
    foregroundColor: isDark ? AppColorsDark.cardDark : AppColors.cardLight,
    iconSize: 24,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
      // side: BorderSide(color: context.primaryColor.shade100, width: 4),
    ),
  );
}
