import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dportfolio/appData/app_data_export.dart';

import 'constants.dart';

Locale getCurrentLocale(BuildContext context) =>
    // If the user has saved app language manually it will load from shared preferences,
    // in the other way picks device locale
    PrefService.getString(Constants.PREFERENCE_LANGUAGE_MANUAL) != null
        ? Locale(PrefService.getString(Constants.PREFERENCE_LANGUAGE_MANUAL))
        : Localizations.localeOf(context, nullOk: true);

String getCurrentLanguageCodeByConstant(BuildContext context, Locale locale) {
  if (locale.languageCode == Constants.LANG_EN)
    return Constants.LANG_EN;
  else if (locale.languageCode == Constants.LANG_LT)
    return Constants.LANG_LT;
  else
    return Constants.LANG_EN;
}

showErrorSnackbar(GlobalKey<ScaffoldState> scaffoldKey) =>
    scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
      scaffoldKey.currentContext.getString(LocaleKeys.SENDING_ERROR),
    )));

visitPage(GlobalKey<ScaffoldState> scaffoldKey, String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      enableJavaScript: true,
    );
  } else {
    showErrorSnackbar(scaffoldKey);
  }
}
