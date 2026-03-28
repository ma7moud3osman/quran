import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/font/app_style_text.dart';
import '../utils/font/font_size.dart';

SnackBarThemeData getSnackBarTheme({required bool isDark}) {
  return SnackBarThemeData(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    actionTextColor: Colors.yellow,
    actionBackgroundColor: isDark ? AppColorsDark.error : AppColors.error,
    width: 350,
    contentTextStyle: getMediumStyle(
      fontSize: FontSize.s14,
      height: 0,
      color: isDark ? AppColorsDark.textDark : AppColors.whiteLight,
    ),
  );
}
