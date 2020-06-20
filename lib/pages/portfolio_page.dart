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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
              centerTitle: true,
              title: Text(
                Constants.APP_NAME,
                style: Theme.of(context).textTheme.headline5,
              )),
          body: Container()),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
