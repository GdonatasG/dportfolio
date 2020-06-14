import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dportfolio/appData/app_data_export.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherPlatformsPage extends StatefulWidget {
  @override
  _OtherPlatformsPageState createState() => _OtherPlatformsPageState();
}

class _OtherPlatformsPageState extends State<OtherPlatformsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
        onTap: () async {
          if (await canLaunch(pageUrl)) {
            await launch(
              pageUrl,
              enableJavaScript: true,
            );
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
              context.getString(LocaleKeys.SENDING_ERROR),
            )));
          }
        },
        child: Container(
          color: bgColor,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                      fontSize: 28,
                      fontStyle: FontStyle.normal,
                      color: titleColor),
                ),
              )
            ],
          ),
        ),
      );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
