import 'package:dportfolio/pages/about_me/TimelineData.dart';
import 'package:dportfolio/utils/timeline/timeline.dart';
import 'package:dportfolio/utils/timeline/timeline_model.dart';
import 'package:flutter/material.dart';
import 'package:dportfolio/appData/app_data_extensions.dart';

class TimelineWidget extends StatelessWidget {
  final bool isSliverList;

  const TimelineWidget({Key key, this.isSliverList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timeline.builder(
        isSliverList: true,
        itemBuilder: centerTimelineBuilder,
        itemCount: educations.length,
        physics: BouncingScrollPhysics(),
        position: TimelinePosition.Center);
  }

  TimelineModel centerTimelineBuilder(BuildContext context, int i) {
    final education = educations[i];
    return TimelineModel(LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
          ),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                IconTheme(
                    data: IconThemeData(
                        color: Theme.of(context).accentColor, size: 28),
                    child: education.icon),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  context.getString(education.time),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Divider(),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  context.getString(education.name),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                IconTheme(
                    data: Theme.of(context).iconTheme,
                    child: Icon(Icons.location_on)),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  context.getString(education.location),
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontSize: 12.5),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        );
      },
    ),
        position:
            i % 2 == 0 ? TimelineItemPosition.right : TimelineItemPosition.left,
        isFirst: i == 0,
        isLast: i == educations.length,
        iconBackground: Theme.of(context).accentColor);
    //icon: doodle.icon);
  }
}
