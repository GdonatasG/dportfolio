import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/extensions.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preferences.dart';

class LanguagePage extends StatefulWidget {
  final String title;

  LanguagePage({this.title});

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initLanguage(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PreferencePage([
        RadioPreference(
          Text(
            context.getString(LocaleKeys.LANGUAGE_ENGLISH),
            style: Theme.of(context).textTheme.headline4,
          ),
          Constants.LANG_EN,
          Constants.PREFERENCE_LANGUAGE,
          isDefault: true,
          onSelect: () {
            // post frame callback to avoid calling Builder when
            // app is already building (on start)
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              _updateLanguage(Locale(Constants.LANG_EN), context);
            });
          },
        ),
        Divider(),
        RadioPreference(
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
    );
  }

  _updateLanguage(Locale locale, BuildContext context) {
    EzLocalizationBuilder.of(context).changeLocale(locale);
  }

  _initLanguage(BuildContext context) {
    // helps to select radio preference by current language
    PrefService.setString(
        Constants.PREFERENCE_LANGUAGE,
        getCurrentLanguageCodeByConstant(
            context, EzLocalization.of(context).locale));
  }
}
