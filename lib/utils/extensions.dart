import 'package:flutter/cupertino.dart';
import 'package:preferences/preferences.dart';

import 'constants.dart';

Locale getCurrentLocale(BuildContext context) {
  return PrefService.getString(Constants.PREFERENCE_LANGUAGE) != null
      ? Locale(PrefService.getString(Constants.PREFERENCE_LANGUAGE))
      : Localizations.localeOf(context, nullOk: true);
}

String getCurrentLanguageCodeByConstant(BuildContext context, Locale locale) {
  if (locale.languageCode == Constants.LANG_EN)
    return Constants.LANG_EN;
  else if (locale.languageCode == Constants.LANG_LT)
    return Constants.LANG_LT;
  else
    return Constants.LANG_EN;
}
