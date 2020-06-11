import 'package:dportfolio/pages/settings/language_preference_page.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:dportfolio/utils/themes/app_theme_dark.dart';
import 'package:dportfolio/utils/themes/app_theme_light.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preferences/preference_page.dart';
import 'package:preferences/preferences.dart';
import 'package:provider/provider.dart';
import 'package:dportfolio/utils/themes/theme_changer.dart';
import 'package:ez_localization/ez_localization.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: _buildPreferenceSettings(context),
      ),
    );
  }

  _buildPreferenceSettings(BuildContext context) {
    ThemeChanger _themeChanger =
        Provider.of<ThemeChanger>(context, listen: false);
    return PreferencePage([
      _itemTitle(context.getString(LocaleKeys.ABOUT_APPLICATION)),
      Divider(),
      _itemText(
          context.getString(
              LocaleKeys.VERSION, {'version': Constants.APP_VERSION}),
          leading: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.info,
            ),
          ),
          isSingleLine: false),
      Divider(),
      _itemText(
          context.getString(
              LocaleKeys.CREATORS, {'creators': Constants.APP_CREATORS}),
          leading: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.person,
            ),
          ),
          isSingleLine: false),
      Divider(),
      _itemText(context.getString(LocaleKeys.BUILT_WITH),
          leading: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.smartphone,
            ),
          ),
          isSingleLine: false),
      Divider(),
      _itemTitle(context.getString(LocaleKeys.PERSONALIZATION)),
      Divider(),
      RadioPreference(
        Text(context.getString(LocaleKeys.THEME_LIGHT),
            style: Theme.of(context).textTheme.headline4),
        Constants.PREFERENCES_UI_THEME_LIGHT,
        Constants.PREFERENCE_UI_THEME,
        isDefault: true,
        onSelect: () {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _themeChanger.setTheme(appThemeLight, context);
          });
        },
      ),
      Divider(),
      RadioPreference(
        Text(context.getString(LocaleKeys.THEME_DARK),
            style: Theme.of(context).textTheme.headline4),
        Constants.PREFERENCES_UI_THEME_DARK,
        Constants.PREFERENCE_UI_THEME,
        onSelect: () {
          _themeChanger.setTheme(appThemeDark, context);
        },
      ),
      Divider(),
      // language page
      _itemText(context.getString(LocaleKeys.LANGUAGE),
          leading: IconTheme(
            data: Theme.of(context).iconTheme,
            child: Icon(
              Icons.language,
            ),
          ),
          trailing: IconTheme(
              data: Theme.of(context).iconTheme,
              child: Icon(Icons.arrow_forward)), onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LanguagePage(
                  title: context.getString(LocaleKeys.LANGUAGE),
                ),
            fullscreenDialog: true));
      }),
      Divider(),
    ]);
  }

  _itemTitle(String title) {
    return Container(
      child: PreferenceTitle(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  _itemText(String text,
      {Widget leading,
      Widget trailing,
      Function onTap,
      bool isSingleLine = true}) {
    return PreferenceText(
      text,
      style: Theme.of(context).textTheme.headline4,
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      isSingleLine: isSingleLine,
    );
  }
}
