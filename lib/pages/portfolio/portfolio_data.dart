import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';

class PortfolioItem {
  final String title;
  final String url;
  final String googlePlayUrl;
  final String appStoreUrl;
  final String githubUrl;
  final String about;
  final List<String> platformsAndTechnologies;
  final String coverUrl;
  final List<String> listOfImagesUrl;

  const PortfolioItem(
      {this.title,
      this.url,
      this.googlePlayUrl,
      this.appStoreUrl,
      this.githubUrl,
      this.about,
      this.platformsAndTechnologies,
      this.coverUrl,
      this.listOfImagesUrl});
}

const List<PortfolioItem> portfolioItems = [
  PortfolioItem(
      title: Constants.APP_NAME,
      googlePlayUrl:
          "https://play.google.com/store/apps/details?id=com.app.dportfolio",
      githubUrl: "https://github.com/GdonatasG/dportfolio",
      about: LocaleKeys.DPORTFOLIO_ABOUT,
      platformsAndTechnologies: [
        "Flutter",
        "Dart",
        "Mobile",
        "Android", ///*"iOS"*/
      ],
      coverUrl: "assets/images/portfolio/dportfolio/dportfolio_cover.png",
      listOfImagesUrl: [
        "assets/images/portfolio/dportfolio/dportfolio1.png",
        "assets/images/portfolio/dportfolio/dportfolio2.png",
        "assets/images/portfolio/dportfolio/dportfolio3.png",
        "assets/images/portfolio/dportfolio/dportfolio4.png",
        "assets/images/portfolio/dportfolio/dportfolio5.png",
        "assets/images/portfolio/dportfolio/dportfolio_cover.png"
      ])
];
