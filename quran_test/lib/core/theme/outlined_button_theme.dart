import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/app_decoration/app_radius.dart';

OutlinedButtonThemeData getOutlinedButtonTheme({required bool isDark}) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(
        isDark ? AppColorsDark.primary : AppColors.primary,
      ),
      backgroundColor: WidgetStateProperty.all(
        isDark ? AppColorsDark.whiteDark : AppColors.whiteLight,
      ),
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(borderRadius: AppRadius.radiusAll),
      ),
      elevation: WidgetStateProperty.all(1),
      fixedSize: WidgetStateProperty.all(Size(120, 40)),
    ),
  );
}
