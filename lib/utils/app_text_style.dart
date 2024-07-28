import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle customtextStyle(
      {TextOverflow? overflow,
      double fontSize = 16,
      FontWeight? fontWeight,
      Color? color = Colors.black,
      double? letterSpacing,
      FontStyle? fontStyle,
      TextDecorationStyle? decorationStyle,
      Color? decorationColor,
      String? fontFamily,
      TextDecoration? textDecoration,
      double? height}) {
    return TextStyle(
        color: color,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize,
        fontStyle: fontStyle,
        decorationStyle: decorationStyle,
        decorationColor: decorationColor,
        fontFamily: fontFamily,
        overflow: overflow ?? TextOverflow.ellipsis,
        letterSpacing: letterSpacing ?? 0.0,
        decoration: textDecoration,
        height: height ?? 1);
  }
}
