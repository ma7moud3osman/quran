import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/app_decoration/app_radius.dart';
import '../utils/font/app_style_text.dart';
import '../utils/font/font_size.dart';

ElevatedButtonThemeData getElevatedButtonTheme({required bool isDark}) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: getRegularStyle(
        color: isDark ? AppColorsDark.whiteDark : AppColors.whiteLight,
        fontSize: FontSize.s16,
      ),
      backgroundColor: isDark ? AppColorsDark.primary : AppColors.primary,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.radiusAll),
    ),
  );
}
