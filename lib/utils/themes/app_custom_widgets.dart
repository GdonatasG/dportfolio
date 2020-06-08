import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppCustomWidgets {
  AppCustomWidgets._();

  static Widget logoWidget = Image.asset(
    "assets/images/logo.png",
    width: 146,
    height: 219,
    fit: BoxFit.fill,
  );

  static customLightShapeForFlatButton() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: AppColors.lightestGrey, width: 1.2));
  }

  static CircularProgressIndicator customProgressIndicatorDark =
      CircularProgressIndicator(
    valueColor: new AlwaysStoppedAnimation<Color>(AppColors.textColorDark),
    strokeWidth: 2.0,
  );
}
