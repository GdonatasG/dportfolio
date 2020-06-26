import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/extensions.dart';
import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherPlatformsPage extends StatefulWidget {
  @override
  _OtherPlatformsPageState createState() => _OtherPlatformsPageState();
}

class _OtherPlatformsPageState extends State<OtherPlatformsPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      key: _scaffoldKey,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Wrap(
                    spacing: 30,
                    direction: Axis.horizontal,
                    children: [
                      _buildPlatformItem(
                          context: context,
                          bgColor: Colors.blue.shade900,
                          titleColor: AppColors.textColorLight,
                          iconSrc: Constants.ICON_SRC_FREELANCER,
                          title: Constants.TITLE_FREELANCER,
                          pageUrl: Constants.URL_FREELANCER),
                      _buildPlatformItem(
                          context: context,
                          bgColor: Colors.lightGreenAccent.shade700,
                          titleColor: AppColors.textColorLight,
                          iconSrc: Constants.ICON_SRC_UPWORK,
                          title: Constants.TITLE_UPWORK,
                          pageUrl: Constants.URL_UPWORK),
                      _buildPlatformItem(
                          context: context,
                          bgColor: Colors.blue.shade400,
                          titleColor: AppColors.textColorLight,
                          iconSrc: Constants.ICON_SRC_LINKEDIN,
                          title: Constants.TITLE_LINKEDIN,
                          pageUrl: Constants.URL_LINKEDIN),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildPlatformItem(
          {BuildContext context,
          Color bgColor,
          Color titleColor,
          String iconSrc,
          String title,
          String pageUrl}) =>
      GestureDetector(
        onTap: () => visitPage(_scaffoldKey, pageUrl),
        child: Container(
          color: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconSrc,
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 10,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 18,
                      fontStyle: FontStyle.normal,
                      color: titleColor),
                ),
              )
            ],
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
