import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'app_colors.dart';

class AppCustomWidgets {
  AppCustomWidgets._();

  static Widget logoWidget = Image.asset(
    Constants.SRC_LOGO,
    width: 146,
    height: 219,
    fit: BoxFit.fill,
  );

  static customLightShapeForFlatButton() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: AppColors.lightestGrey, width: 1.2));
  }

  static circularProgressIndicator(Color color) {
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(color),
      strokeWidth: 2.0,
    );
  }
}
