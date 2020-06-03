import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              LocaleKeys.APP_NAME,
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Text("portfolio"),
        ),
      ),
    );
  }
}
