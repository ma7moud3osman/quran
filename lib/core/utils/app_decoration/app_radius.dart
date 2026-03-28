import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static BorderRadius icon = const BorderRadius.all(Radius.circular(16));

  static BorderRadius card = const BorderRadius.all(Radius.circular(16));
  static BorderRadius button = const BorderRadius.all(Radius.circular(16));
  static BorderRadius circle = const BorderRadius.all(Radius.circular(100));
  static BorderRadius image = const BorderRadius.all(Radius.circular(16));
  static BorderRadius formFields = const BorderRadius.all(Radius.circular(8));
  static BorderRadius switchRadius = const BorderRadius.all(
    Radius.circular(32),
  );
  static BorderRadius bottomSheet = const BorderRadius.only(
    topRight: Radius.circular(20),
    topLeft: Radius.circular(20),
  );
  static const radiusAll = BorderRadius.all(Radius.circular(10));
  static const border = BorderRadius.all(Radius.circular(10));
  static const zero = BorderRadius.all(Radius.circular(0));
  static Radius radius = const Radius.circular(20);
  static double carouselHeader = 6;
  static double circleAvatarLarge = 50;
  static double circleAvatarMedium = 16;
}
