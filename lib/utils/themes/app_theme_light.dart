import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeLight = ThemeData(
    primaryColor: AppColors.textColorLight,
    primaryColorLight: Colors.white,
    primaryColorDark: AppColors.lighterGrey,
    accentColor: AppColors.greetingBackground,
    backgroundColor: Colors.grey.shade50,
    unselectedWidgetColor: AppColors.textColorDark,
    cursorColor: AppColors.textColorDark,
    iconTheme: IconThemeData(color: Colors.grey[800]),
    indicatorColor: AppColors.greetingBackground,
    textTheme: TextTheme(
        subtitle1: TextStyle(
            fontFamily: "ComicSansMs",
            fontSize: 15.5,
            color: AppColors.textColorDark),
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
            fontFamily: "ComicSansMs",
            fontSize: 15,
            color: AppColors.greetingBackground,
            fontStyle: FontStyle.italic)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.textColorDark,
        selectedItemColor: AppColors.greetingBackground,
        unselectedIconTheme: IconThemeData(
            size: AppCustomDimensions.BOTTOM_BAR_ITEM_Icon_SIZE_UNSELECTED),
        selectedIconTheme: IconThemeData(
            size: AppCustomDimensions.BOTTOM_BAR_ITEM_Icon_SIZE_SELECTED)),
    tabBarTheme: TabBarTheme(
        labelColor: AppColors.greetingBackground,
        unselectedLabelColor: AppColors.textColorDark),
    dividerTheme: DividerThemeData(
        color: AppColors.textColorDark, space: 0.5, thickness: 0.2),
    buttonTheme: ButtonThemeData(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: AppColors.textColorDark, width: 1.5)),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColorDark),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColorDark)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColorDark)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColorDark))));
