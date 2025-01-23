import 'package:flutter/material.dart';

const biteColorsTheme = ColorScheme(
  primary: Color(0xFFC5D544),
  secondary: Color(0xFFF8F8F8),
  error: Color(0xFFD54444),
  surface: Color(0xFFF8F8F8),
  brightness: Brightness.light,
  onPrimary: Color(0xFF303030),
  onSecondary: Color(0xFF303030),
  onError: Color(0xFF303030),
  onSurface: Color(0xFF303030),
);

abstract final class BiteColors {
  static const textColor = Color(0xFF303030);

  static const neutral1 = Color(0xFF919191);

  static const bgColor = Color(0xFFF8F8F8);
  static const bgCardsColor = Color(0xFFF6F6F6);
  static const bgAlertColor = Color(0xFFD9D9D9);
  static const bgDisabledColor = Color(0xFFBABABA);

  static const primaryColor = Color(0xFFC5D544);
  static const errorColor = Color(0xFFD54444);
  static const attentionColor = Color(0xFFF0DD4F);

  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
}
