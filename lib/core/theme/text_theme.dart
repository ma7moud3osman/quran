import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/font/app_style_text.dart';

TextTheme getTextTheme({required BuildContext context, required bool isDark}) {
  final textTheme = Theme.of(context).textTheme;
  return textTheme.copyWith(
    displayLarge: getBoldStyle(
      fontSize: 56,
      color: isDark ? AppColorsDark.textDark : AppColors.primary.shade900,
    ),
    displayMedium: getBoldStyle(
      fontSize: 40,
      color: isDark ? AppColorsDark.textDark : AppColors.primary.shade900,
    ),
    displaySmall: getBoldStyle(
      fontSize: 32,
      color: isDark ? AppColorsDark.textDark : AppColors.primary.shade900,
    ),
    headlineLarge: getMediumStyle(
      fontSize: 32,
      color: isDark ? AppColorsDark.whiteDark : AppColors.primary.shade900,
    ),
    headlineMedium: getMediumStyle(
      fontSize: 28,
      color: isDark ? AppColorsDark.textDark : AppColors.primary.shade900,
    ),
    headlineSmall: getMediumStyle(
      fontSize: 24,
      color: isDark ? AppColorsDark.titleDark : AppColors.primary.shade900,
    ),
    titleLarge: getRegularStyle(
      fontSize: 24,
      color: isDark ? AppColorsDark.titleDark : AppColors.primary,
    ),
    titleMedium: getRegularStyle(
      fontSize: 22,
      color: isDark ? AppColorsDark.titleDark : AppColors.primary,
    ),
    titleSmall: getRegularStyle(
      fontSize: 20,
      color: isDark ? AppColorsDark.titleDark : AppColors.primary,
    ),
    labelLarge: getMediumStyle(
      fontSize: 18,
      color: isDark ? AppColorsDark.whiteDark : AppColors.grey.shade900,
    ),
    labelMedium: getMediumStyle(
      fontSize: 16,
      color: isDark ? AppColorsDark.titleDark : AppColors.grey.shade900,
    ),
    labelSmall: getMediumStyle(
      fontSize: 14,
      color: isDark ? AppColorsDark.textDark : AppColors.grey.shade900,
    ),
    bodyLarge: getLightStyle(
      fontSize: 16,
      color: isDark ? AppColorsDark.textDark : AppColors.grey,
      height: 1.25,
    ),
    bodyMedium: getLightStyle(
      fontSize: 14,
      color: isDark ? AppColorsDark.textDark : AppColors.grey,
      height: 1.2,
    ),
    bodySmall: getLightStyle(
      fontSize: 12,
      color: isDark ? AppColorsDark.textDark : AppColors.grey,
      height: 1.25,
    ),
  );
}
