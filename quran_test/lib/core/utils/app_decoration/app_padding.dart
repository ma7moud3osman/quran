import 'package:flutter/material.dart';

class AppPadding {
  AppPadding._();

  static final page = const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
  static final section = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static final bottomNavBar = const EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 24,
  ).copyWith(bottom: 16);

  static final horizontal1 = EdgeInsets.symmetric(horizontal: 12);
  static final pageHorizontal = const EdgeInsets.symmetric(horizontal: 16);
  static final pageTablet = const EdgeInsets.all(64);
  static final iconButton = EdgeInsets.all(8);
  static final card = EdgeInsets.all(16);
  static final smallCard = EdgeInsets.all(8);
  static final chip = EdgeInsets.symmetric(horizontal: 8, vertical: 2);
  static final button = EdgeInsets.symmetric(horizontal: 16, vertical: 4);
  static final horizontal = EdgeInsets.symmetric(horizontal: 16);
  static final vertical = EdgeInsets.symmetric(vertical: 16);
  static final all = EdgeInsets.all(12);
  static final textFields = EdgeInsets.symmetric(horizontal: 8, vertical: 16);

  static const bottom = EdgeInsets.only(bottom: 8);
  static const header = EdgeInsets.only(top: 24, bottom: 12);
  static const message = EdgeInsets.only(bottom: 90);
}
