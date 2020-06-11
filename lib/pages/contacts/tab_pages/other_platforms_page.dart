import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez_localization/ez_localization.dart';
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
                    _buildItem(context, Constants.LOGO_SRC_FREELANCER,
                        Constants.TITLE_FREELANCER, Constants.URL_FREELANCER),
                    _buildItem(context, Constants.LOGO_SRC_UPWORK,
                        Constants.TITLE_UPWORK, Constants.URL_UPWORK),
                    _buildItem(context, Constants.LOGO_SRC_LINKEDIN,
                        Constants.TITLE_LINKEDIN, Constants.URL_LINKEDIN),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildItem(BuildContext context, String imageSrc, String title,
          String pageUrl) =>
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
          //margin: EdgeInsets.only(top: 20),
          constraints: BoxConstraints(maxWidth: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: Theme.of(context).unselectedWidgetColor,
                    width: 1.2,
                  ),
                ),
                child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.transparent,
                    //backgroundColor: AppColors.lightGrey,
                    child: ClipOval(
                      child: Image.asset(
                        imageSrc,
                        fit: BoxFit.fill,
                      ),
                    )),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontSize: 24, fontStyle: FontStyle.normal),
              )
            ],
          ),
        ),
      );

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
