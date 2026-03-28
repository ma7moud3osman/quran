import 'package:flutter/material.dart';

import 'font_size.dart';

TextStyle _getTextStyle({
  required double fontSize,
  double? height,
  required FontWeight fontWeight,
  required Color color,
}) {
  return TextStyle(
    fontSize: fontSize,
    height: height,
    color: color,
    fontWeight: fontWeight,
    letterSpacing: 0,
  );
}

TextStyle getBlackStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.black,
    color: color,
  );
}

TextStyle getExtraBoldStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.extraBold,
    color: color,
  );
}

TextStyle getBoldStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.bold,
    color: color,
  );
}

TextStyle getSemiBoldStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.semiBold,
    color: color,
  );
}

TextStyle getMediumStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.medium,
    color: color,
  );
}

TextStyle getRegularStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.regular,
    color: color,
  );
}

TextStyle getLightStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.light,
    color: color,
  );
}

TextStyle getExtraLightStyle({
  required double fontSize,
  double? height,
  required Color color,
}) {
  return _getTextStyle(
    fontSize: fontSize,
    height: height,
    fontWeight: FontWeightManager.extraLight,
    color: color,
  );
}
