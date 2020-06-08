import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeLight = ThemeData(
    primaryColor: Colors.grey[100],
    primaryColorLight: Colors.white,
    primaryColorDark: AppColors.lighterGrey,
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
          color: AppColors.textColorDark,
        ),
        headline4: TextStyle(
            fontFamily: "Roboto", fontSize: 14, color: AppColors.textColorDark),
        headline6: TextStyle(
            fontFamily: "Billabong",
            fontSize: 20,
            color: AppColors.greetingBackground,
            fontStyle: FontStyle.italic)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.textColorDark,
        selectedItemColor: AppColors.greetingBackground,
        unselectedIconTheme: IconThemeData(size: 22),
        selectedIconTheme: IconThemeData(size: 22)),
    dividerTheme: DividerThemeData(
        color: AppColors.textColorDark, space: 0.5, thickness: 0.2),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: AppColors.textColorDark, width: 1.2)),
    ));
