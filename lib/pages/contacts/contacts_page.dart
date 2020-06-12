import 'package:dportfolio/pages/contacts/tab_pages/email_page.dart';
import 'package:dportfolio/pages/contacts/tab_pages/other_platforms_page.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dportfolio/appData/app_data_export.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with SingleTickerProviderStateMixin {
  int tabItemCount = 2;
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: this.tabItemCount, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              context.getString(LocaleKeys.HIRE_ME),
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
        bottom: TabBar(
          labelStyle: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontSize: AppCustomDimensions.TAB_BAR_ITEM_TITLE_SIZE),
          unselectedLabelStyle: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontSize: AppCustomDimensions.TAB_BAR_ITEM_TITLE_SIZE),
          tabs: [
            // email page tab
            Tab(text: context.getString(LocaleKeys.TAB_EMAIL_ME).toUpperCase()),
            // other platforms page tab
            Tab(
              text: context
                  .getString(LocaleKeys.TAB_OTHER_PLATFORMS)
                  .toUpperCase(),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [EmailPage(), OtherPlatformsPage()],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
