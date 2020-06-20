import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dportfolio/appData/app_data_export.dart';

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

  static stickyHeaderLayout(
          {@required String title, @required BuildContext context}) =>
      Container(
          color: Theme.of(context).primaryColorDark,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ));
}
