import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/single-bulletin/build-event-item.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'manage-events-controller.dart';

class ManageEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<ManageEventsController>(
        init: ManageEventsController(),
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Add Assignment',
                          style: TextStyle(
                            color: redColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Assignments',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Bulletin - ' + _.bulletinName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: _.events.map<Widget>(
                      (assignment) {
                        return buildEventItem(
                          title: assignment["happening"]["title"],
                          assignedTo: assignment["assigne"],
                          time: assignment["happening"]["date_time"],
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
