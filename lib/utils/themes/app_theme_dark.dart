import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeDark = ThemeData(
    primaryColor: Colors.grey[800],
    primaryColorLight: AppColors.lighterGrey,
    primaryColorDark: Colors.grey[400],
    accentColor: Colors.grey[800],
    textTheme: TextTheme(
        headline5: TextStyle(
            fontFamily: "Billabong",
            fontSize: 27,
            color: AppColors.textColorLight),
        headline2: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textColorDark),
        headline3: TextStyle(
          fontSize: 15,
          color: AppColors.textColorOrange,
        ),
        headline4: TextStyle(
            fontFamily: "Roboto", fontSize: 14, color: AppColors.textColorDark),
        headline6: TextStyle(
            fontFamily: "Billabong",
            fontSize: 20,
            color: AppColors.textColorOrange,
            fontStyle: FontStyle.italic)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.textColorLight,
        selectedItemColor: AppColors.textColorOrange,
        unselectedIconTheme: IconThemeData(size: 22),
        selectedIconTheme: IconThemeData(size: 22)),
    dividerTheme: DividerThemeData(
        color: AppColors.textColorDark, space: 0.5, thickness: 0.2),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: AppColors.textColorDark, width: 1.2)),
    ));
