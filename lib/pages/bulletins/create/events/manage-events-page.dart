import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/add%20assignment/add_assignment.dart';
import 'package:churchappenings/pages/bulletins/single-bulletin/build-event-item.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_card.dart';
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
                        onTap: () {
                          Get.to(AddAssignmentPage(
                            bulletinId: _.bulletinId,
                          ));
                        },
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Member & Designation',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Department',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: _.deptEvents.map<Widget>(
                      (assignment) {
                        return buildEventItem(
                          title: assignment["dept_happening"]["title"],
                          assignedTo: assignment["dept_happening"]["department"]
                              ["name"],
                          time: assignment["dept_happening"]["date_time"],
                        );
                      },
                    ).toList(),
                  ),
                  // SectionListView(
                  //   title: 'Members',
                  //   listView: ListView.builder(
                  //     itemCount: 1,
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return CustomCard(
                  //           title: 'Zainab',
                  //           assignee: 'Person',
                  //           datetime: 'date');
                  //     },
                  //   ),
                  // ),
                  // SectionListView(
                  //   title: 'Department',
                  //   listView: ListView.builder(
                  //     itemCount: 1,
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return CustomCard(
                  //           title: 'Zainab',
                  //           assignee: 'Person',
                  //           datetime: 'date');
                  //     },
                  //   ),
                  // ),
                  // SectionListView(
                  //   title: 'Designation',
                  //   listView: ListView.builder(
                  //     itemCount: 1,
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return CustomCard(
                  //           title: 'Zainab',
                  //           assignee: 'Person',
                  //           datetime: 'date');
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SectionListView extends StatelessWidget {
  final String? title;

  final ListView listView;
  SectionListView({
    required this.title,
    required this.listView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title ?? "",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        listView ?? Container(),
      ],
    );
  }
}
