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

TextStyle _h1TextStyle = const TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w500,
);

TextStyle _h2TextStyle = const TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w500,
);

TextStyle _h3TextStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
);

class AppTheme {
  static ThemeData get mainTheme => ThemeData(
        backgroundColor: whiteSnow,
        textTheme: TextTheme(
          headline1: _h1TextStyle,
          headline2: _h2TextStyle,
          headline3: _h3TextStyle,
          bodyText1: _defaultTextStyle,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: _buttonBorderRadius,
            padding: _outlinedButtonPadding,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: _outlinedButtonPadding,
            shape: _buttonBorderRadius,
            primary: purpleLight,
            textStyle: _h3TextStyle,
          ),
        ),
      );
}
