import 'package:flutter/material.dart';

DrawerThemeData getDrawerTheme({
  required BuildContext context,
  required bool isDark,
}) {
  return DrawerThemeData(
    backgroundColor: isDark ? Colors.white : Colors.white,
    elevation: 25,
  );
}
