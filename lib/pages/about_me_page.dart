import 'package:dportfolio/utils/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutMePage extends StatefulWidget {
  @override
  _AboutMePageState createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
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
      body: Container(
        child: Text("about me"),
      ),
    );
  }
}
