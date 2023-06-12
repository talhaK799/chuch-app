import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/my-events/build-event-option.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'build-event-item.dart';
import 'my-events-controller.dart';

class MyEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<MyEventsController>(
        global: false,
        init: MyEventsController(),
        builder: (_) {
          Widget widget = Container();

          if (_.activeEventBy == 'Upcoming' && _.events != null) {
            widget = Column(
              children: _.events
                  .map<Widget>((event) => buildEventItem(event))
                  .toList(),
            );
          }

          if (_.activeEventBy == 'Past' && _.pastEvents != null) {
            widget = Column(
              children: [
                Column(
                  children: _.pastEvents
                      .map<Widget>((event) => buildEventItem(event))
                      .toList(),
                ),
                _.allPastEventsFetched
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          _.handleLoadMorePast();
                        },
                        child: Container(
                          child: Text('Load More'),
                        ),
                      ),
              ],
            );
          }

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      GestureDetector(
                        onTap: () {
                          _.navigateToCreate();
                        },
                        child: Text(
                          'Create Event',
                          style: TextStyle(color: redColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'My Events',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Create and invite people to events',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildEventOption(
                        'Upcoming',
                        _.activeEventBy,
                        _.handleSubMenuTap,
                      ),
                      SizedBox(width: 20),
                      buildEventOption(
                        'Past',
                        _.activeEventBy,
                        _.handleSubMenuTap,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  _.loading
                      ? Container(
                          margin: EdgeInsets.only(top: 100),
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : widget
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
