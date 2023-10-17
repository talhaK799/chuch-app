import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/add%20assignment/add_assignment.dart';
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
                    height: 20,
                  ),

                  ///
                  /// assignment type selection
                  ///
                  assignmentTypeSelection(_),
                  SizedBox(height: 5),
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
                  _.isStandardAssignment == false
                      ? Column(
                          children: _.dynamicEvents.map<Widget>(
                            (assignment) {
                              List<String> emailList =
                                  (assignment["assigne"] as String)
                                      .split(',')
                                      .map((email) => email.trim())
                                      .toList();
                              return buildDynamicItem(
                                  title: assignment["happening"]["title"],
                                  assignedTo: assignment["assigne"],
                                  time: assignment["happening"]["date_time"],
                                  status: assignment["status"],
                                  assignees: emailList);
                            },
                          ).toList(),
                        )
                      : Column(
                          children: _.standardEvents.map<Widget>(
                            (assignment) {
                              return buildEventItem(
                                  title: assignment["happening"]["title"],
                                  assignedTo: assignment["assigne"],
                                  time: assignment["happening"]["date_time"],
                                  status: assignment["status"]);
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
                  _.isStandardAssignment == false
                      ? Column(
                          children: _.deptDynamicEvents.map<Widget>(
                            (assignment) {
                              List<String> emailList =
                                  (assignment["assignees"] as String)
                                      .split(',')
                                      .map((email) => email.trim())
                                      .toList();
                              return buildDynamicItem(
                                  title: assignment["dept_happening"]["title"],
                                  assignedTo: assignment["dept_happening"]
                                      ["department"]["name"],
                                  time: assignment["dept_happening"]
                                      ["date_time"],
                                  status: assignment["status"],
                                  assignees: emailList);
                            },
                          ).toList(),
                        )
                      : Column(
                          children: _.deptEvents.map<Widget>(
                            (assignment) {
                              return buildEventItem(
                                  title: assignment["dept_happening"]["title"],
                                  assignedTo: assignment["dept_happening"]
                                      ["department"]["name"],
                                  time: assignment["dept_happening"]
                                      ["date_time"],
                                  status: assignment["status"]);
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

  assignmentTypeSelection(ManageEventsController controller) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            controller.isStandardAssignment = true;
            controller.update();
          },
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: controller.isStandardAssignment
                    ? redColor
                    : redColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4)),
            child: Center(
                child: Text(
              "Standard Assignment",
              style: TextStyle(
                  fontSize: 13,
                  color: controller.isStandardAssignment
                      ? Colors.white
                      : Colors.black),
            )),
          ),
        )),
        SizedBox(width: 20),
        Expanded(
            child: GestureDetector(
          onTap: () {
            controller.isStandardAssignment = false;
            controller.update();
          },
          child: Container(
            decoration: BoxDecoration(
                color: controller.isStandardAssignment == false
                    ? redColor
                    : redColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4)),
            height: 30,
            child: Center(
                child: Text(
              "Dynamic Assignment",
              style: TextStyle(
                  fontSize: 13,
                  color: controller.isStandardAssignment == false
                      ? Colors.white
                      : Colors.black),
            )),
          ),
        ))
      ],
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
        listView,
      ],
    );
  }
}
