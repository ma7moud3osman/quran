import 'package:flutter/material.dart';

import '../extension/colors_extension.dart';
import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import 'app_bar_theme.dart';
import 'bottom_navigation_bar_theme.dart';
import 'bottom_sheet_theme.dart';
import 'button_theme.dart';
import 'card_theme.dart';
import 'divider_theme.dart';
import 'drawer_theme.dart';
import 'dropdown_menu_theme.dart';
import 'elevated_button_theme.dart';
import 'expansion_tile_theme.dart';
import 'floating_action_button_theme.dart';
import 'icon_button_theme.dart';
import 'input_decoration_theme.dart';
import 'list_tile_theme.dart';
import 'outlined_button_theme.dart';
import 'progress_indicator_theme.dart';
import 'snack_bar_theme.dart';
import 'tab_bar_theme.dart';
import 'text_theme.dart';

ThemeData getAppTheme(BuildContext context, bool isDark) {
  return ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    primaryColor: context.primaryColor,
    scaffoldBackgroundColor: isDark
        ? AppColorsDark.backgroundDark
        : AppColors.backgroundLight,
    bottomNavigationBarTheme: getBottomNavigationBarTheme(isDark: isDark),
    snackBarTheme: getSnackBarTheme(isDark: isDark),
    splashColor: isDark ? AppColorsDark.primary : AppColors.primary,
    progressIndicatorTheme: getProgressIndicatorTheme(isDark: isDark),
    // divider Theme
    dividerTheme: getDividerTheme(isDark: isDark),
    // bottomSheet Theme
    bottomSheetTheme: getBottomSheetTheme(isDark: isDark),
    dropdownMenuTheme: getDropdownMenuTheme(context: context, isDark: isDark),
    // card Theme
    cardTheme: getCardTheme(isDark: isDark),

    // floatingActionButton Theme
    floatingActionButtonTheme: getFloatingActionButtonTheme(
      context: context,
      isDark: isDark,
    ),
    // expansionTile theme
    expansionTileTheme: getExpansionTileTheme(isDark: isDark),
    // tabBar Theme
    tabBarTheme: getTabBarTheme(isDark: isDark),
    // listTile Theme
    listTileTheme: getListTileTheme(isDark: isDark),
    // appBar theme
    appBarTheme: getAppBarTheme(isDark: isDark),
    // button Theme
    buttonTheme: getButtonTheme(isDark: isDark),
    // iconButton Theme
    iconButtonTheme: getIconButtonTheme(isDark: isDark),

    // elevatedButton Theme
    elevatedButtonTheme: getElevatedButtonTheme(isDark: isDark),
    // text Theme
    textTheme: getTextTheme(context: context, isDark: isDark),
    // outlinedButton Theme
    outlinedButtonTheme: getOutlinedButtonTheme(isDark: isDark),
    // inputDecoration Theme
    inputDecorationTheme: getInputDecorationTheme(isDark: isDark),
    // drawer Theme
    drawerTheme: getDrawerTheme(context: context, isDark: isDark),
  );
}
