import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  primaryColorDark: AppColors.primaryDark,
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
      color: AppColors.primary,
    ),
    headline4: TextStyle(
        fontFamily: "Roboto", fontSize: 14, color: AppColors.textColorDark),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: AppColors.textColorDark,
      selectedItemColor: AppColors.greetingBackground,
      unselectedIconTheme: IconThemeData(size: 22),
      selectedIconTheme: IconThemeData(size: 22)),
);

class AppColors {
  AppColors._();

  static Color greetingBackground = "#ff5252".toColor();
  static Color primary = Colors.grey[100];
  static Color primaryDark = Colors.grey[400];
  static Color textColorDark = Colors.grey[800];
}

class AppCustomDimensions {
  AppCustomDimensions._();

  static const double bottomBarItemTitleSize = 12.0;
}

class AppCustomWidgets {
  AppCustomWidgets._();

  static Widget logoWidget = Image.asset(
    "assets/images/logo.png",
    width: 146,
    height: 219,
    fit: BoxFit.fill,
  );

  static Widget loadingWidgetGreetingColor = Container(
    color: AppColors.greetingBackground,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [logoWidget, circularProgressIndicator],
      ),
    ),
  );

  static customShapeForFlatButton() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: AppColors.primary, width: 1.2));
  }

  static CircularProgressIndicator circularProgressIndicator =
      CircularProgressIndicator(
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black87),
    strokeWidth: 2.0,
  );
}
