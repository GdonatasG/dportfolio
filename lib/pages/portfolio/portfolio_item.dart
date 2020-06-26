import 'package:dportfolio/pages/portfolio/portfolio_data.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:dportfolio/utils/extensions.dart';
import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:dportfolio/utils/themes/app_custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:dportfolio/appData/app_data_export.dart';

class Portfolio extends StatefulWidget {
  final PortfolioItem portfolioItem;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Portfolio({Key key, this.portfolioItem, this.scaffoldKey})
      : super(key: key);

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio>
    with AutomaticKeepAliveClientMixin {
  int _currentPicture = 0;
  PageController _controller;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  child: AppCustomWidgets.stickyHeaderLayout(
                      title: widget.portfolioItem.title,
                      context: context,
                      centerTitle: true)),
              Container(
                  width: double.infinity,
                  child: Flex(
                    direction: Axis.vertical,
                    children: [
                      Image.asset(
                        widget.portfolioItem.coverUrl,
                      )
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(context.getString(widget.portfolioItem.about),
                      style: Theme.of(context).textTheme.headline4)),
              SizedBox(
                height: 10,
              ),
              Wrap(
                children: List.generate(
                    widget.portfolioItem.platformsAndTechnologies.length,
                    (index) => AppCustomWidgets.backgroundedTag(
                        bgColor: Theme.of(context).primaryColorDark,
                        textTag: Text(
                            widget
                                .portfolioItem.platformsAndTechnologies[index],
                            style: Theme.of(context).textTheme.headline4))),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Divider()),
              SizedBox(
                height: 5,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  _buildActionButton(
                      FontAwesome.picture_o,
                      context.getString(LocaleKeys.PICTURES),
                      () => _showProjectPictures(
                          widget.portfolioItem.listOfImagesUrl,
                          widget.portfolioItem.title)),
                  widget.portfolioItem.githubUrl != null
                      ? _buildActionButton(
                          FontAwesome.github,
                          Constants.TITLE_GITHUB,
                          () => visitPage(widget.scaffoldKey,
                              widget.portfolioItem.githubUrl))
                      : Container(),
                  widget.portfolioItem.googlePlayUrl != null
                      ? _buildActionButton(
                          MaterialCommunityIcons.google_play,
                          Constants.TITLE_GOOGLE_PLAY,
                          () => visitPage(widget.scaffoldKey,
                              widget.portfolioItem.googlePlayUrl))
                      : Container(),
                  widget.portfolioItem.appStoreUrl != null
                      ? _buildActionButton(
                          Ionicons.ios_appstore,
                          Constants.TITLE_APP_STORE,
                          () => visitPage(widget.scaffoldKey,
                              widget.portfolioItem.appStoreUrl))
                      : Container(),
                  widget.portfolioItem.url != null
                      ? _buildActionButton(
                          Icons.web,
                          context.getString(LocaleKeys.PAGE),
                          () => visitPage(
                              widget.scaffoldKey, widget.portfolioItem.url))
                      : Container(),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      );

  _buildTechnologyItem(String technology) => Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).primaryColorDark,
        ),
        child: Text(technology, style: Theme.of(context).textTheme.headline4),
      );

  _buildActionButton(IconData icon, String title, Function onPressed) =>
      Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        child: FlatButton(
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconTheme(
                  data: Theme.of(context).iconTheme.copyWith(size: 20),
                  child: Icon(icon)),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      );

  _showProjectPictures(List<String> picturesUrl, String projectName) {
    _controller = PageController(initialPage: _currentPicture);
    return showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
              builder: (BuildContext context, setState) => Container(
                child: Material(
                  type: MaterialType.transparency,
                  child: Flex(direction: Axis.vertical, children: [
                    // ***CLOSE BUTTON**
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.white,
                              size: 27.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ***PICTURES***
                    Flexible(
                      flex: 8,
                      child: PhotoViewGallery.builder(
                        scrollPhysics: const BouncingScrollPhysics(),
                        builder: (BuildContext context, int index) {
                          return PhotoViewGalleryPageOptions(
                            imageProvider: AssetImage(picturesUrl[index]),
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            initialScale:
                                PhotoViewComputedScale.contained * 0.8,
                          );
                        },
                        itemCount: picturesUrl.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPicture = index;
                          });
                        },
                        loadingBuilder: (context, event) => Center(
                          child: Container(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              value: event == null
                                  ? 0
                                  : event.cumulativeBytesLoaded /
                                      event.expectedTotalBytes,
                            ),
                          ),
                        ),
                        backgroundDecoration:
                            BoxDecoration(color: Colors.transparent),
                        pageController: _controller,
                        //onPageChanged: onPageChanged,
                      ),
                    ),
                    // ***CLICKABLE DOTS TO SHOW IMAGES LENGTH***
                    Flexible(
                        child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: picturesUrl.map((url) {
                        int index = picturesUrl.indexOf(url);
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(index,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 3.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPicture == index
                                  ? Theme.of(context).accentColor
                                  : Colors.grey[100],
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                  ]),
                ),
              ),
            ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
