import 'package:dportfolio/pages/about_me_page.dart';
import 'package:dportfolio/pages/contacts_page.dart';
import 'package:dportfolio/pages/portfolio_page.dart';
import 'package:dportfolio/pages/settings_page.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

import 'language_page.dart';

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
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
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
              title: Text(LocaleKeys.PAGE_TITLE_ABOUT.tr()),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.code),
              title: Text(LocaleKeys.PAGE_TITLE_PORTFOLIO.tr()),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text(LocaleKeys.PAGE_TITLE_CONTACT.tr()),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(LocaleKeys.PAGE_TITLE_SETTINGS.tr()),
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
