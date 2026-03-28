import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/font/font_size.dart';

BottomNavigationBarThemeData getBottomNavigationBarTheme({
  required bool isDark,
}) {
  return BottomNavigationBarThemeData(
    backgroundColor: isDark ? AppColors.grey.shade800 : AppColors.cardLight,
    elevation: 0,
    selectedLabelStyle: TextStyle(fontSize: FontSize.s12),
    unselectedLabelStyle: TextStyle(fontSize: FontSize.s12),
    unselectedItemColor: isDark
        ? AppColors.grey.shade400
        : AppColors.iconsLight,
    selectedItemColor: isDark ? AppColors.primary.shade300 : AppColors.primary,
    type: BottomNavigationBarType.fixed,
  );
}
