import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';

DividerThemeData getDividerTheme({required bool isDark}) {
  return DividerThemeData(
    space: 0,
    color: isDark ? AppColorsDark.borderDark : AppColors.borderLight,
    thickness: 1.2,
  );
}
