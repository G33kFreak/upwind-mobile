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

TextStyle _body1 = const TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

TextStyle _h1TextStyle = const TextStyle(
  fontSize: 36,
  fontWeight: FontWeight.w500,
);

TextStyle _h2TextStyle = const TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w500,
  color: whiteSnow,
);

TextStyle _h3TextStyle = const TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: whiteSnow,
);

TextStyle _h4TextStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: purpleDark,
);

TextStyle _subtitle1 = const TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: whiteSnow,
);

class AppTheme {
  static ThemeData get mainTheme => ThemeData(
        backgroundColor: whiteSnow,
        textTheme: TextTheme(
          headline1: _h1TextStyle,
          headline2: _h2TextStyle,
          headline3: _h3TextStyle,
          headline4: _h4TextStyle,
          bodyText1: _body1,
          bodyText2: _defaultTextStyle,
          subtitle1: _subtitle1,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: purpleDark,
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
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: purpleDark,
        ),
      );
}
