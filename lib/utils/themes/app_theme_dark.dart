import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeDark = ThemeData(
    primaryColor: AppColors.textColorDark,
    primaryColorLight: AppColors.textColorLight,
    primaryColorDark: Colors.grey.shade700,
    accentColor: AppColors.textColorBlue,
    backgroundColor: AppColors.darkestGrey,
    unselectedWidgetColor: AppColors.textColorLight,
    cursorColor: AppColors.textColorLight,
    iconTheme: IconThemeData(color: AppColors.lightGrey),
    indicatorColor: AppColors.textColorBlue,
    textTheme: TextTheme(
        subtitle1: TextStyle(
            fontFamily: "ComicSansMs",
            fontSize: 15.5,
            color: AppColors.textColorBlue),
        headline5: TextStyle(
            fontFamily: "Billabong",
            fontSize: 27,
            color: AppColors.textColorLight),
        headline2: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textColorLight),
        headline3: TextStyle(
          fontSize: 15,
          color: AppColors.textColorLight,
        ),
        headline4: TextStyle(
            fontFamily: "Roboto",
            fontSize: 14,
            color: AppColors.textColorLight),
        headline6: TextStyle(
            fontFamily: "ComicSansMs",
            fontSize: 15,
            color: AppColors.textColorBlue,
            fontStyle: FontStyle.italic)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.textColorLight,
        selectedItemColor: AppColors.textColorBlue,
        unselectedIconTheme: IconThemeData(
            size: AppCustomDimensions.BOTTOM_BAR_ITEM_Icon_SIZE_UNSELECTED),
        selectedIconTheme: IconThemeData(
            size: AppCustomDimensions.BOTTOM_BAR_ITEM_Icon_SIZE_SELECTED)),
    tabBarTheme: TabBarTheme(
        labelColor: AppColors.textColorBlue,
        unselectedLabelColor: AppColors.textColorLight),
    dividerTheme: DividerThemeData(
        color: AppColors.textColorLight, space: 0.5, thickness: 0.2),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: AppColors.textColorLight, width: 1.5)),
    ),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.textColorDark,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textColorLight),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColorLight)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColorLight)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textColorBlue))));
