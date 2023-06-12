import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'build-calendar-by-option.dart';
import 'build-calendar-event.dart';
import 'calendar-controller.dart';

class CalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<CalendarControllerX>(
        global: false,
        init: CalendarControllerX(),
        builder: (_) {
          Widget widget = Container();

          if (_.activeCalendarBy == 'Upcoming' && _.upcomingEvents != null) {
            widget = Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                children: _.upcomingEvents
                    .map<Widget>((event) => buildCalendarEvent(event))
                    .toList(),
              ),
            );
          }

          if (_.activeCalendarBy == 'Past' && _.pastEvents != null) {
            widget = Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: Column(
                children: [
                  Column(
                    children: _.pastEvents
                        .map<Widget>(
                          (event) => buildCalendarEvent(event),
                        )
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
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navigateToWidget(),
                    Row(
                      children: [
                        buildCalendarByOption(
                          'Past',
                          _.activeCalendarBy,
                          _.handleSubMenuTap,
                        ),
                        SizedBox(width: 15),
                        buildCalendarByOption(
                          'Upcoming',
                          _.activeCalendarBy,
                          _.handleSubMenuTap,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My Calendar',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: _.loading
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(child: widget),
              ),
            ],
          );
        },
      ),
    );
  }
}
