import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/font/app_style_text.dart';
import '../utils/font/font_size.dart';

TabBarThemeData getTabBarTheme({required bool isDark}) {
  return TabBarThemeData(
    dividerColor: isDark ? AppColorsDark.primary : AppColors.backgroundLight,
    indicatorColor: isDark ? AppColorsDark.primary : AppColors.primary,
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: isDark ? AppColorsDark.primary : AppColors.primary,
    labelStyle: getLightStyle(
      color: isDark ? AppColorsDark.primary : AppColors.primary,
      fontSize: FontSize.s14,
    ),
    unselectedLabelColor: isDark ? AppColorsDark.primary : AppColors.grey,
    unselectedLabelStyle: getLightStyle(
      color: isDark ? AppColorsDark.primary : AppColors.grey,
      fontSize: FontSize.s14,
    ),
  );
}
