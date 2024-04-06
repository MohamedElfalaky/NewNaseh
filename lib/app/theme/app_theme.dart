import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

ThemeData whiteTheme = ThemeData(
  primaryColor: Constants.primaryAppColor,
  primarySwatch: Colors.lightBlue,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  fontFamily: 'Cairo',
  inputDecorationTheme:   InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.primaryAppColor),
            borderRadius: BorderRadius.circular(10)
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.primaryAppColor),
          borderRadius: BorderRadius.circular(10)

      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Constants.primaryAppColor),
          borderRadius: BorderRadius.circular(10)

      )),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Palette.kToDark,
  ).copyWith(background: Constants.primaryAppColor),
  scaffoldBackgroundColor: Constants.whiteAppColor,
);

class Palette {
  static MaterialColor kToDark = MaterialColor(
    Constants.primaryAppColor.value,
    <int, Color>{
      50: Constants.primaryAppColor.withOpacity(0.1),
      100: Constants.primaryAppColor.withOpacity(0.2),
      200: Constants.primaryAppColor.withOpacity(0.3),
      300: Constants.primaryAppColor.withOpacity(0.4),
      400: Constants.primaryAppColor.withOpacity(0.5),
      500: Constants.primaryAppColor.withOpacity(0.6),
      600: Constants.primaryAppColor.withOpacity(0.7),
      700: Constants.primaryAppColor.withOpacity(0.8),
      800: Constants.primaryAppColor.withOpacity(0.9),
      900: Constants.primaryAppColor,
    },
  );
}
