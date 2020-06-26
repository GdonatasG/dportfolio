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

  static stickyHeaderLayout(
          {@required String title,
          bool centerTitle = false,
          @required BuildContext context}) =>
      Container(
          color: Theme.of(context).primaryColorDark,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Text(
            title,
            textAlign: centerTitle ? TextAlign.center : TextAlign.start,
            style: Theme.of(context).textTheme.subtitle1,
          ));

  static backgroundedTag({
    @required Color bgColor,
    @required Text textTag,
  }) =>
      Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
        ),
        child: textTag,
      );
}
