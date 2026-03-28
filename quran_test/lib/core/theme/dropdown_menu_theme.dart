import 'package:flutter/material.dart';
import 'package:widgets_box/widgets_box.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';

DropdownMenuThemeData getDropdownMenuTheme({
  required BuildContext context,
  required bool isDark,
}) {
  return DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      fillColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return isDark ? AppColorsDark.whiteDark : AppColors.whiteLight;
        } else if (states.contains(WidgetState.disabled)) {
          return isDark ? AppColorsDark.borderDark : AppColors.borderLight;
        }
        return isDark ? AppColorsDark.whiteDark : AppColors.whiteLight;
      }),
      suffixIconColor: isDark ? AppColorsDark.error : AppColors.error,
      iconColor: isDark ? AppColorsDark.error : AppColors.error,
      prefixIconColor: isDark ? AppColorsDark.error : AppColors.error,
      hintStyle: context.labelLarge?.copyWith(
        color: isDark ? AppColorsDark.error : AppColors.error,
      ),
    ),
    textStyle: context.displaySmall?.copyWith(
      color: isDark ? AppColorsDark.error : AppColors.error,
    ),
    menuStyle: MenuStyle(
      backgroundColor: WidgetStateProperty.all(
        isDark ? AppColorsDark.whiteDark : AppColors.whiteLight,
      ),
    ),
  );
}
