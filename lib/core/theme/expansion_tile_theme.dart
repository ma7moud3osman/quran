import 'package:flutter/material.dart';

ExpansionTileThemeData getExpansionTileTheme({required bool isDark}) {
  return const ExpansionTileThemeData(
    // textColor: isDark ? AppColorsDark.primaryDark : AppColors.primaryLight,
    // iconColor: isDark ? AppColorsDark.primaryDark : AppColors.primaryLight,
    childrenPadding: EdgeInsets.all(8),
    // collapsedTextColor: isDark ? AppColorsDark.primaryDark : AppColors.textLight,
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(8),
    // ),
  );
}
