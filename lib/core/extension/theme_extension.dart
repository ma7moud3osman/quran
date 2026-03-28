import 'package:flutter/material.dart';

extension GetThemeNames on ThemeMode {
  String get toThemeName {
    switch (this) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
    }
  }
}

extension GetThemeEnum on String {
  ThemeMode get toThemeEnum {
    switch (this) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}
