import 'package:dportfolio/pages/contacts/tab_pages/email_page.dart';
import 'package:dportfolio/pages/contacts/tab_pages/other_platforms_page.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dportfolio/appData/app_data_export.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key}) : super(key: key);
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
        centerTitle: true,
        title: Text(
          context.getString(LocaleKeys.GET_IN_TOUCH),
          style: Theme.of(context).textTheme.headline5,
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
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [EmailPage(), OtherPlatformsPage()],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
