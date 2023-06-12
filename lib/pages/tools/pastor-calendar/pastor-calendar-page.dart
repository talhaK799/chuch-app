import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/pastor-calendar/manage/pastor-manage-page.dart';
import 'package:churchappenings/pages/tools/pastor-calendar/pastor-calendar-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'build-calendar-by-option.dart';

class PastorCalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<PastorCalendarController>(
          global: false,
          init: PastorCalendarController(),
          builder: (_) {
            if (_.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      GestureDetector(
                        onTap: () {
                          Get.to(PastorManagePage());
                        },
                        child: Text(
                          'Manage',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            color: redColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Appointments',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Pastors appointment here',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      buildCalendarByOption(
                        'Upcoming',
                        'Upcoming',
                        () {},
                      ),
                      SizedBox(width: 15),
                      buildCalendarByOption(
                        'Past',
                        'Upcoming',
                        () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _.upcomingRequests.map<Widget>((item) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey.withOpacity(
                                    0.3,
                                  ),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item["description"],
                                ),
                                SizedBox(height: 20),
                                Text('Are you going ?'),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: redColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'Yes',
                                            style: TextStyle(
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: redColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'No',
                                            style: TextStyle(
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: redColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'Maybe',
                                            style: TextStyle(
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      color: redColor,
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.remove_circle,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
