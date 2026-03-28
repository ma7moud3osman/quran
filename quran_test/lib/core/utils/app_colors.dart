import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const MaterialColor primary = MaterialColor(0xFF1C1954, {
    50: Color(0xFFEBEAF3),
    100: Color(0xFF5B5995),
    200: Color(0xFF4A4884),
    300: Color(0xFF3A3874),
    400: Color(0xFF2B2864),
    500: Color(0xFF1C1954),
    600: Color(0xFF18164A),
    700: Color(0xFF151340),
    800: Color(0xFF111035),
    900: Color(0xFF0E0C2B),
  });
  static const MaterialColor secondary = MaterialColor(0xFFE51E26, {
    50: Color(0xFFFDECEC),
    100: Color(0xFFF47A7E),
    200: Color(0xFFF06267),
    300: Color(0xFFED4A50),
    400: Color(0xFFE9343B),
    500: Color(0xFFE51E26),
    600: Color(0xFFCC1A21),
    700: Color(0xFFB3171D),
    800: Color(0xFFA01419),
    900: Color(0xFF8E1116),
  });

  static const MaterialColor grey = MaterialColor(0xFF9E9E9E, {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFF5F5F5),
    300: Color(0xFFE0E0E0),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF9E9E9E),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    900: Color(0xFF09090B),
  });

  static const MaterialColor success = MaterialColor(0xFF22C55E, {
    50: Color(0xFFF0FDF4),
    100: Color(0xFFF0FDF4),
    200: Color(0xFFBBF7D0),
    300: Color(0xFF86EFAC),
    400: Color(0xFF4ADE80),
    500: Color(0xFF22C55E),
    600: Color(0xFF16A34A),
    700: Color(0xFF15803D),
    800: Color(0xFF166534),
    900: Color(0xFF052E16),
  });
  static const MaterialColor warning = MaterialColor(0xFFFDE047, {
    50: Color(0xFFFEFCE8),
    100: Color(0xFFFEFCE8),
    200: Color(0xFFFEF9C3),
    300: Color(0xFFFEF08A),
    400: Color(0xFFFDE68A),
    500: Color(0xFFFDE047),
    600: Color(0xFFCA8A04),
    700: Color(0xFFA16207),
    800: Color(0xFF854D0E),
    900: Color(0xFF422006),
  });

  static const MaterialColor error = MaterialColor(0xffE51E26, {
    50: Color(0xFFFEF2F2),
    100: Color(0xFFFEF2F2),
    200: Color(0xFFFECACA),
    300: Color(0xFFFCA5A5),
    400: Color(0xFFF87171),
    500: Color(0xffE51E26),
    600: Color(0xFFDC2626),
    700: Color(0xFFB91C1C),
    800: Color(0xFF991B1B),
    900: Color(0xFF450A0A),
  });

  static const borderLight = Color(0xFFE0E0E0);

  static const iconsLight = Color(0xFF9CA3AF);

  static const whiteLight = Color(0xFFFFFFFF);

  static const blackLight = Color(0xFF000000);

  static const headlineLight = Color(0xFF111416);

  static const blueColor = Color(0xFF56BEE5);

  static final titleLight = grey.shade900;

  static const bodyLight = Color(0xFF607589);

  static final backgroundLight = grey.shade100;

  static const cardLight = Color(0xFFFFFFFF);

  static const shadowLight = Color(0xFFF3F4F6);

  static const transparent = Colors.transparent;

  static const cardTextGradient = LinearGradient(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
    colors: [Colors.black38, Colors.black26, Colors.transparent],
  );

  static final imageOverlayGradient = LinearGradient(
    colors: [
      primary,
      primary.withValues(alpha: .5),
      primary.withValues(alpha: .2),
    ],
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );
}
