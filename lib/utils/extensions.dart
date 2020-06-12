import 'package:flutter/cupertino.dart';
import 'package:preferences/preferences.dart';

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
