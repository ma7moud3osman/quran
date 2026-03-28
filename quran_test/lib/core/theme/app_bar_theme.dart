import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/font/app_style_text.dart';
import '../utils/font/font_size.dart';

AppBarTheme getAppBarTheme({required bool isDark}) {
  return AppBarTheme(
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(
      size: FontSize.s16,
      color: isDark ? AppColorsDark.primary : AppColors.primary,
    ),
    backgroundColor: isDark ? AppColors.grey.shade800 : AppColors.whiteLight,
    shadowColor: isDark ? Colors.transparent : AppColors.transparent,
    titleTextStyle: getSemiBoldStyle(
      fontSize: FontSize.s16,
      height: 0,
      color: isDark ? AppColorsDark.titleDark : AppColors.titleLight,
    ),
    surfaceTintColor: isDark ? Colors.transparent : AppColors.transparent,
    // backgroundColor: MaterialStateColor.resolveWith(
    //   (states) {
    //     if (states.contains(MaterialState.scrolledUnder)) {
    //       return isDark ? AppColorsDark.white : Colors.white;
    //     }
    //     return isDark ? AppColorsDark.white : Colors.white;
    //   },
    // ),
    // systemOverlayStyle: const SystemUiOverlayStyle(
    //   statusBarIconBrightness: Brightness.dark,
    //   statusBarBrightness: Brightness.light,
    // ),
  );
}
