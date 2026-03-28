import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/font/app_style_text.dart';
import '../utils/font/font_size.dart';

ListTileThemeData getListTileTheme({required bool isDark}) {
  return ListTileThemeData(
    visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
    minVerticalPadding: 1,
    minLeadingWidth: 0,
    tileColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return isDark ? AppColorsDark.whiteDark : AppColors.whiteLight;
      } else if (states.contains(WidgetState.disabled)) {
        return isDark ? AppColorsDark.borderDark : AppColors.borderLight;
      }
      return isDark ? AppColorsDark.whiteDark : AppColors.whiteLight;
    }),
    titleTextStyle: getSemiBoldStyle(
      fontSize: FontSize.s16,
      color: isDark ? AppColorsDark.titleDark : AppColors.titleLight,
    ),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: isDark ? AppColorsDark.borderDark : AppColors.borderLight,
        width: 1,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
  );
}
