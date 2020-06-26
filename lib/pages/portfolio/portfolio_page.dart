import 'package:dportfolio/pages/portfolio/portfolio_data.dart';
import 'package:dportfolio/pages/portfolio/portfolio_item.dart';
import 'package:dportfolio/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PortfolioPage extends StatefulWidget {
  PortfolioPage({Key key}) : super(key: key);

  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with AutomaticKeepAliveClientMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  int _currentPortfolio = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
                centerTitle: true,
                title: Text(
                  Constants.APP_NAME,
                  style: Theme.of(context).textTheme.headline5,
                )),
            body: _buildPortfolioPage()));
  }

  final List portfolioSliders = portfolioItems
      .map((portfolioItem) => Portfolio(
            portfolioItem: portfolioItem,
            scaffoldKey: _scaffoldKey,
          ))
      .toList();

  _buildPortfolioPage() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: PageView(
                children: portfolioSliders,
                onPageChanged: (index) {
                  setState(() {
                    _currentPortfolio = index;
                  });
                },
                controller: _controller,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: portfolioItems.map((url) {
                int index = portfolioItems.indexOf(url);
                return GestureDetector(
                  onTap: () => _controller.animateToPage(index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPortfolio == index
                          ? Theme.of(context).accentColor
                          : Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      );

  @override
  bool get wantKeepAlive => true;
}
