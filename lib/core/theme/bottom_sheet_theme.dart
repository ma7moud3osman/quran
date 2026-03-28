import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/app_decoration/app_radius.dart';

BottomSheetThemeData getBottomSheetTheme({required bool isDark}) {
  return BottomSheetThemeData(
    backgroundColor: isDark ? AppColorsDark.whiteDark : AppColors.whiteLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: AppRadius.radius,
        topLeft: AppRadius.radius,
      ),
    ),
  );
}
