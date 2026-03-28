import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';

ButtonThemeData getButtonTheme({required bool isDark}) {
  return ButtonThemeData(
    shape: const StadiumBorder(),
    textTheme: ButtonTextTheme.primary,
    disabledColor: isDark ? AppColorsDark.primary : AppColors.primary,
    buttonColor: isDark ? AppColorsDark.primary : AppColors.primary,
    splashColor: isDark ? AppColorsDark.primary : AppColors.primary,
  );
}
