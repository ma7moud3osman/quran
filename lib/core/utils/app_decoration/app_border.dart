import 'package:flutter/material.dart';
import '../../extension/colors_extension.dart';

class AppBorder {
  AppBorder._();

  static Border border(BuildContext context) => Border.all(
        color: context.grey.shade300,
        width: 0.5,
      );

  static Border customBorder(Color? color, {double? width}) =>
      Border.all(color: color ?? Colors.green, width: width ?? 1);
}

class AppShadow {
  AppShadow._();

  static List<BoxShadow> card = [
    const BoxShadow(
      color: Color(0x19000000),
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];
}
