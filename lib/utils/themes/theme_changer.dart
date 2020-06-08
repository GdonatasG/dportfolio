import 'package:dportfolio/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:ez_localization/ez_localization.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme, BuildContext context) {
    _themeData = theme;

    notifyListeners();

    // notifying EzLocalizationBuilder to rebuild ui
    EzLocalizationBuilder.of(context).changeLocale(getCurrentLocale(context));
  }
}
