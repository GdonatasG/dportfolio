import 'package:dportfolio/pages/about_me_page.dart';
import 'package:dportfolio/pages/contacts_page.dart';
import 'package:dportfolio/pages/portfolio_page.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preference_service.dart';

import 'settings/settings_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  List<Widget> pageList = List<Widget>();

  @override
  void initState() {
    _generateBottomBarPages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: _getStatusBarIconBrightness()));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          showUnselectedLabels: true,
          currentIndex: _selectedPage,
          selectedLabelStyle: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontSize: AppCustomDimensions.bottomBarItemTitleSize),
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontSize: AppCustomDimensions.bottomBarItemTitleSize),
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              title: Text(
                context.getString(LocaleKeys.PAGE_TITLE_ABOUT),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              title: Text(
                context.getString(LocaleKeys.PAGE_TITLE_PORTFOLIO),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text(
                context.getString(LocaleKeys.PAGE_TITLE_CONTACT),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                context.getString(LocaleKeys.PAGE_TITLE_SETTINGS),
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
      ),
    );
  }

  Brightness _getStatusBarIconBrightness() {
    String currentTheme = PrefService.getString(Constants.PREFERENCE_UI_THEME);
    if (currentTheme == Constants.PREFERENCES_UI_THEME_LIGHT)
      return Brightness.dark;
    else if (currentTheme == Constants.PREFERENCES_UI_THEME_DARK)
      return Brightness.light;
    return Brightness.light;
  }

  _generateBottomBarPages() {
    pageList.add(AboutMePage());
    pageList.add(PortfolioPage());
    pageList.add(ContactsPage());
    pageList.add(SettingsPage());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  Future<bool> _onBackPressed() async {
    if (_selectedPage != 0) {
      setState(() {
        _selectedPage = 0;
      });
      return false;
    }
    return true;
  }
}
