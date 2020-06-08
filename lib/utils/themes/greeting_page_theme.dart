import 'package:flutter/material.dart';

import 'app_colors.dart';

final ThemeData greetingTheme = ThemeData(
  primaryColor: Colors.grey[100],
  primaryColorLight: Colors.white,
  primaryColorDark: Colors.grey[400],
  accentColor: AppColors.greetingBackground,
  textTheme: TextTheme(
      headline5: TextStyle(
          fontFamily: "Billabong",
          fontSize: 27,
          color: AppColors.greetingBackground),
      headline2: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.textColorDark),
      headline3: TextStyle(
        fontSize: 15,
        color: AppColors.lightestGrey,
      ),
      headline4: TextStyle(
          fontFamily: "Roboto", fontSize: 14, color: AppColors.textColorDark),
      headline6: TextStyle(
          fontFamily: "Billabong",
          fontSize: 20,
          color: AppColors.greetingBackground,
          fontStyle: FontStyle.italic)),
);
