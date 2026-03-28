import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';

extension IsDarkTheme on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

extension AppColorsExtension on BuildContext {
  MaterialColor get primaryColor =>
      isDark ? AppColorsDark.primary : AppColors.primary;
  MaterialColor get secondaryColor =>
      isDark ? AppColorsDark.secondary : AppColors.secondary;

  Color get borderColor =>
      isDark ? AppColorsDark.borderDark : AppColors.borderLight;

  MaterialColor get grey => isDark ? AppColorsDark.grey : AppColors.grey;

  MaterialColor get success =>
      isDark ? AppColorsDark.success : AppColors.success;
  MaterialColor get warning =>
      isDark ? AppColorsDark.warning : AppColors.warning;
  MaterialColor get errorColor =>
      isDark ? AppColorsDark.error : AppColors.error;

  Color get iconsColor =>
      isDark ? AppColorsDark.iconsDark : AppColors.iconsLight;
  Color get cardColor => isDark ? AppColorsDark.cardDark : AppColors.cardLight;
  Color get baseColor =>
      isDark ? AppColorsDark.blackDark : AppColors.blackLight;
  Color get titleColor =>
      isDark ? AppColorsDark.titleDark : AppColors.titleLight;
  Color get bodyColor => isDark ? AppColorsDark.textDark : AppColors.bodyLight;

  Color get backgroundColor =>
      isDark ? AppColorsDark.backgroundDark : AppColors.backgroundLight;
  Color get refreshColor =>
      isDark ? AppColorsDark.whiteDark : AppColors.whiteLight;
}
