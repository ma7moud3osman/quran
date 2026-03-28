import 'package:flutter/material.dart';

class AppColorsDark {
  AppColorsDark._();

  static const MaterialColor primary = MaterialColor(0xFFc3c8e6, {
    50: Color(0xFF23318b),
    100: Color(0xFF2b3b97),
    200: Color(0xFF3445a3),
    300: Color(0xFF3a4dac),
    400: Color(0xFF9ca5d5),
    500: Color(0xFF9ca5d5),
    600: Color(0xFF9ca5d5),
    700: Color(0xFFc3c8e6),
    800: Color(0xFFc3c8e6),
    900: Color(0xFFe3f2fd),
  });

  static const MaterialColor secondary = MaterialColor(0xFFff7814, {
    50: Color(0xFF4d1d02),
    100: Color(0xFF703203),
    200: Color(0xFF934904),
    300: Color(0xFFb65f05),
    400: Color(0xFFD97706),
    500: Color(0xFFff7814),
    600: Color(0xFFff9847),
    700: Color(0xFFffb87a),
    800: Color(0xFFffd6ad),
    900: Color(0xFFffebd6),
  });

  static const MaterialColor grey = MaterialColor(0xFF4d4d4d, {
    900: Color(0xFFeef2f6),
    800: Color(0xFFeef2f6),
    700: Color(0xFFeef2f6),
    600: Color(0xFF7794bb),
    500: Color(0xFFbbcadd),
    400: Color(0xFFbbcadd),
    300: Color(0xFF7794bb),
    200: Color(0xFF334966),
    100: Color(0xFF223144),
    50: Color(0xFF111822),
  });

  static const MaterialColor success = MaterialColor(0xffA6E5B8, {
    900: Color(0xfff0fdf4),
    800: Color(0xfff0fdf4),
    700: Color(0xffbbf7d0),
    600: Color(0xff86efac),
    500: Color(0xff4ade80),
    400: Color(0xFF22C55E),
    300: Color(0xFF16A34A),
    200: Color(0xFF15803D),
    100: Color(0xFF166534),
    50: Color(0xff14532d),
  });

  static const MaterialColor warning = MaterialColor(0xfffacc15, {
    900: Color(0xfffefce8),
    800: Color(0xffFEF08A),
    700: Color(0xfffef08a),
    600: Color(0xffFACC15),
    500: Color(0xfffacc15),
    400: Color(0xffeab308),
    300: Color(0xffca8a04),
    200: Color(0xffa16207),
    100: Color(0xff713F12),
    50: Color(0xff713f12),
  });

  static const MaterialColor error = MaterialColor(0xffEF4444, {
    900: Color(0xfffef2f2),
    800: Color(0xffFCA5A5),
    700: Color(0xfffecaca),
    600: Color(0xfffca5a5),
    500: Color(0xffEF4444),
    400: Color(0xffef4444),
    300: Color(0xffdc2626),
    200: Color(0xffb91c1c),
    100: Color(0xFF7F1D1D),
    50: Color(0xff7f1d1d),
  });

  static const borderDark = Color(0xFF2A3239);
  static const iconsDark = Color(0xFF9CA3AF);
  static const whiteDark = Color(0xFF181C21);
  static const blackDark = Color(0xFFE0E0E0);
  static const titleDark = Color(0xFFB0B0B0);
  static const textDark = Color(0xFFCCCCCC);
  static const backgroundDark = Color(0xFF111822);
  static const cardDark = Color(0xFF223144);
  static const navigationBarDark = Color(0xFF242A30);

  static const LinearGradient aiItineraryGradient = LinearGradient(
    colors: [
      Color(0xFF007ACC), // Darker Blue
      Color(0xFF005A99), // Even Darker Blue
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
