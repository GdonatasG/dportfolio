import 'package:dportfolio/pages/about_me/timeline_widget.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/sabt.dart';
import 'package:dportfolio/utils/themes/app_custom_dimensions.dart';
import 'package:dportfolio/utils/themes/app_custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:preferences/preference_service.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:dportfolio/appData/app_data_extensions.dart';

class AboutMePage extends StatefulWidget {
  AboutMePage({Key key}) : super(key: key);

  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              centerTitle: true,
              stretch: true,
              stretchTriggerOffset: 150.0,
              forceElevated: true,
              // SABT - the class to show title only if FlexibleSpaceBar is already scrolled
              title: SABT(
                child: Text(
                  Constants.APP_NAME,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        _getImageAssetSrcByTheme(),
                        width: AppCustomDimensions.LOGO_FACE_WIDTH,
                        height: AppCustomDimensions.LOGO_FACE_HEIGHT,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Donatas Žitkus",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        context.getString(LocaleKeys.TITLE_MOBILE_DEVELOPER),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).textTheme.headline5.color,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Kaunas, " +
                                context.getString(LocaleKeys.COUNTRY_LITHUANIA),
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: 14, fontFamily: "ComicSansMs"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            _roadToProgrammingLayout(),
            _theBeginningLayout(),
            _universityLayout(),
            _goalsLayout(),
            _skillsLayout(),
            _additionalSkillsLayout(),
            _educationTimelineLayout()
          ]),
        ),
      ),
    ));
  }

  _contentTextWidget(String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
        content,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  _roadToProgrammingLayout() {
    return SliverStickyHeader(
      header: AppCustomWidgets.stickyHeaderLayout(
          title: context.getString(LocaleKeys.TITLE_ROAD_TO_PROGRAMMING),
          context: context),
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
            (context, i) => Column(
                  children: [
                    _contentTextWidget(context
                        .getString(LocaleKeys.ROAD_TO_PROGRAMMING_CONTENT1)),
                    _contentTextWidget(context
                        .getString(LocaleKeys.ROAD_TO_PROGRAMMING_CONTENT2)),
                  ],
                ),
            childCount: 1),
      ),
    );
  }

  _theBeginningLayout() {
    return SliverStickyHeader(
      header: AppCustomWidgets.stickyHeaderLayout(
          title: context.getString(LocaleKeys.TITLE_THE_BEGINNING),
          context: context),
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
            (context, i) => Column(
                  children: [
                    _contentTextWidget(
                        context.getString(LocaleKeys.THE_BEGINNING_CONTENT1)),
                  ],
                ),
            childCount: 1),
      ),
    );
  }

  _universityLayout() {
    return SliverStickyHeader(
      header: AppCustomWidgets.stickyHeaderLayout(
          title: context.getString(LocaleKeys.TITLE_UNIVERSITY),
          context: context),
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
            (context, i) => Column(
                  children: [
                    _contentTextWidget(
                        context.getString(LocaleKeys.UNIVERSITY_CONTENT1)),
                  ],
                ),
            childCount: 1),
      ),
    );
  }

  _goalsLayout() {
    return SliverStickyHeader(
      header: AppCustomWidgets.stickyHeaderLayout(
          title: context.getString(LocaleKeys.TITLE_GOALS), context: context),
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
            (context, i) => Column(
                  children: [
                    _contentTextWidget(
                        context.getString(LocaleKeys.GOALS_CONTENT1)),
                  ],
                ),
            childCount: 1),
      ),
    );
  }

  final List<String> listOfSkills = [
    "Flutter",
    "Kotlin",
    "Java",
    "Google Maps API",
    "Google Firebase",
    "Github",
    "Android",
    "Android Studio",
    "iOS",
  ];

  _skillsLayout() {
    return SliverStickyHeader(
      header: AppCustomWidgets.stickyHeaderLayout(
          title: context.getString(LocaleKeys.TITLE_SKILLS), context: context),
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
            (context, i) => Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(
                    listOfSkills.length,
                    (index) => AppCustomWidgets.backgroundedTag(
                        bgColor: Theme.of(context).primaryColorDark,
                        textTag: Text(listOfSkills[index],
                            style: Theme.of(context)
                                .textTheme
                                .headline4))) /*listOfSkills.map((skill) =>
              AppCustomWidgets.backgroundedTag(
                  bgColor: Theme.of(context).primaryColorDark,
                  textTag: Text(skill,
                      style: Theme.of(context).textTheme.headline4))),*/
                ),
            childCount: 1),
      ),
    );
  }

  _additionalSkillsLayout() {
    return SliverStickyHeader(
      header: AppCustomWidgets.stickyHeaderLayout(
          title: context.getString(LocaleKeys.TITLE_ADDITIONAL_SKILLS),
          context: context),
      sliver: new SliverList(
        delegate: new SliverChildBuilderDelegate(
            (context, i) => _contentTextWidget(
                context.getString(LocaleKeys.ADDITIONAL_SKILLS_CONTENT1)),
            childCount: 1),
      ),
    );
  }

  _educationTimelineLayout() {
    return SliverStickyHeader(
        header: AppCustomWidgets.stickyHeaderLayout(
            title: context.getString(LocaleKeys.TITLE_EDUCATION),
            context: context),
        sliver: TimelineWidget(
          isSliverList: true,
        ));
  }

  _getImageAssetSrcByTheme() {
    if (PrefService.getString(Constants.PREFERENCE_UI_THEME) ==
        Constants.PREFERENCES_UI_THEME_LIGHT)
      return Constants.SRC_FACE_BLACK;
    else if (PrefService.getString(Constants.PREFERENCE_UI_THEME) ==
        Constants.PREFERENCES_UI_THEME_DARK) return Constants.SRC_FACE_WHITE;
    return Constants.SRC_FACE_BLACK;
  }

  @override
  bool get wantKeepAlive => true;
}
