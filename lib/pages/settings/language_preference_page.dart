import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/customPreferences/custom_radio_preference.dart';
import 'package:dportfolio/utils/extensions.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/appData/app_data_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class LanguagePage extends StatefulWidget {
  final String title;

  LanguagePage({Key key, this.title}) : super(key: key);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    _initLanguage(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PreferencePage([
          CustomRadioPreference(
            Text(
              context.getString(LocaleKeys.LANGUAGE_ENGLISH),
              style: Theme.of(context).textTheme.headline4,
            ),
            Constants.LANG_EN,
            Constants.PREFERENCE_LANGUAGE,
            isDefault: true,
            onSelect: () {
              _updateLanguage(Locale(Constants.LANG_EN), context);
            },
          ),
          Divider(),
          CustomRadioPreference(
            Text(context.getString(LocaleKeys.LANGUAGE_LITHUANIAN),
                style: Theme.of(context).textTheme.headline4),
            Constants.LANG_LT,
            Constants.PREFERENCE_LANGUAGE,
            onSelect: () {
              _updateLanguage(Locale(Constants.LANG_LT), context);
            },
          ),
          Divider(),
        ]),
      ),
    );
  }

  _updateLanguage(Locale locale, BuildContext context) {
    // Using other shared pref variable to store user selected language
    // PREFERENCE_LANGUAGE variable is used only to store radio button selection
    PrefService.setString(
        Constants.PREFERENCE_LANGUAGE_MANUAL, locale.languageCode);
    AppDataBuilder.of(context).changeLocale(locale);
  }

  _initLanguage(BuildContext context) {
    // helps to select radio preference by current language
    PrefService.setString(
        Constants.PREFERENCE_LANGUAGE,
        getCurrentLanguageCodeByConstant(
            context, AppLocalizations.of(context).locale));
  }
}
