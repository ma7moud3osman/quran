import 'package:flutter/material.dart';

import '../app/app_prefs.dart';
import '../app/injection_container.dart';
import '../extension/theme_extension.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    final themeMode = sl<AppPreferences>().getThemeApp()?.toThemeEnum;

    final isSystemBrightness =
        themeMode == null || themeMode == ThemeMode.system;
    setThemeApp(themeMode: isSystemBrightness ? ThemeMode.system : themeMode);
  }
  ThemeMode _typeMode = ThemeMode.system;

  ThemeMode get typeMode => _typeMode;
  ThemeMode get getThemeMode => _typeMode;

  ThemeData lightTheme(BuildContext context) => getAppTheme(context, false);
  ThemeData darkTheme(BuildContext context) => getAppTheme(context, true);

  void setThemeApp({required ThemeMode themeMode}) {
    _typeMode = themeMode;
    saveThemeApp();
    notifyListeners();
  }

  void changeThemeMode(ThemeMode mode) {
    _typeMode = mode;
    saveThemeApp();
    notifyListeners();
  }

  void saveThemeApp() {
    sl<AppPreferences>().setThemeApp(mode: _typeMode.toThemeName);
  }
}
