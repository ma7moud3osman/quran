import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';

IconButtonThemeData getIconButtonTheme({required bool isDark}) {
  return IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateColor.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return isDark ? AppColorsDark.primary : AppColors.primary;
        }
        return isDark ? Colors.grey.shade400 : Colors.grey.shade400;
      }),
    ),
  );
}
