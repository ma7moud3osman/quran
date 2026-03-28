import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/app_decoration/app_radius.dart';

CardThemeData getCardTheme({required bool isDark}) {
  return CardThemeData(
    elevation: 0,
    margin: EdgeInsets.zero,
    color: isDark ? AppColorsDark.cardDark : AppColors.whiteLight,
    shape: RoundedRectangleBorder(
      borderRadius: AppRadius.card,
      side: BorderSide(
        color: isDark ? AppColorsDark.borderDark : AppColors.borderLight,
      ),
    ),
    clipBehavior: Clip.antiAlias,
  );
}
