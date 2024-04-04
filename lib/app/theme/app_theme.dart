import 'package:flutter/material.dart';

import '../constants.dart';

ThemeData whiteTheme=ThemeData(
    primaryColor: Constants.primaryAppColor,
    primarySwatch: Colors.lightBlue,
    fontFamily: 'Cairo',
    appBarTheme: const AppBarTheme().copyWith(
      toolbarHeight: 70,
      titleSpacing: 4,
      color: Constants.whiteAppColor,
      elevation: 0,
      titleTextStyle: Constants.mainTitleFont,
    ),
    scaffoldBackgroundColor: Constants.whiteAppColor);