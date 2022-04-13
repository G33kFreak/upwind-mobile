import 'package:flutter/material.dart';

import 'colors.dart';

RoundedRectangleBorder _buttonBorderRadius = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(16.0),
);

EdgeInsetsGeometry _outlinedButtonPadding =
    const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0);

TextStyle _defaultTextStyle = const TextStyle(
  color: textGrey,
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

class AppTheme {
  static ThemeData get mainTheme => ThemeData(
        backgroundColor: whiteSnow,
        textTheme: TextTheme(
          bodyText1: _defaultTextStyle,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: _buttonBorderRadius,
            padding: _outlinedButtonPadding,
          ),
        ),
      );
}
