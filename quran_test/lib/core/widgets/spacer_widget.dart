import 'package:flutter/material.dart';

class AppSpacer {
  AppSpacer._();

  //=============================================
  static double get verticalLarge => 16;

  static double get verticalSmall => 4;

  static double get verticalMedium => 8;

  static double get verticalExtraLarge => 24;

  static double get verticalBig => 32;

  //=============================================
  static double get horizontalSmall => 4;

  static double get horizontalMedium => 8;

  static double get horizontalLarge => 16;

  static double get horizontalExtraLarge => 24;

  static double get horizontalBig => 48;
}

class VerticalSpacer extends StatelessWidget {
  final double height;

  const VerticalSpacer(this.height, {super.key});

  VerticalSpacer.small({super.key}) : height = AppSpacer.verticalSmall;

  VerticalSpacer.medium({super.key}) : height = AppSpacer.verticalMedium;

  VerticalSpacer.large({super.key}) : height = AppSpacer.verticalLarge;

  VerticalSpacer.extra({super.key}) : height = AppSpacer.verticalExtraLarge;

  VerticalSpacer.big({super.key}) : height = AppSpacer.verticalBig;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HorizontalSpacer extends StatelessWidget {
  final double width;

  const HorizontalSpacer(this.width, {super.key});

  HorizontalSpacer.small({super.key}) : width = AppSpacer.horizontalSmall;

  HorizontalSpacer.medium({super.key}) : width = AppSpacer.horizontalMedium;

  HorizontalSpacer.large({super.key}) : width = AppSpacer.horizontalLarge;

  HorizontalSpacer.extra({super.key}) : width = AppSpacer.horizontalExtraLarge;

  HorizontalSpacer.big({super.key}) : width = AppSpacer.horizontalBig;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
