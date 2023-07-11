import 'package:churchappenings/pages/departments/departments-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'add_department_page.dart';
import 'details_dapartment_page.dart';

class DepartmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<DepartmentController>(
        init: DepartmentController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.to(AddDepartmentPage());
                      //   },
                      //   child: Text('Add New'),
                      // ),
                      IconButton(
                          onPressed: () {
                            Get.to(
                              AddDepartmentPage(),
                            );
                          },
                          icon: Icon(Icons.add))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Departments',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'My departments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _.departmentsMember.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    DetailsDepartment(
                                      name: _.departmentsMember[index].name
                                          .toString(),
                                      deptId: _.departmentsMember[index].id
                                          .toString(),
                                    ),
                                  );
                                  // _.sendJoinRequest(
                                  //     _.departmentsMember[index].id!);
                                },
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Name:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.130),
                                      Flexible(
                                        child: Text(
                                          _.departmentsMember[index].name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        'Description:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Flexible(
                                          child: Html(
                                        data:
                                            '${_.departmentsMember[index].desc}',
                                      )),
                                    ],
                                  ),
                                ]),
                              ));

                          // Column(
                          //   children: [
                          //     ListTile(
                          //       title: Text(
                          //           "Name: ${_.departmentsMember[index].name}"),
                          //       subtitle: Html(
                          //           data: "${_.departmentsMember[index].desc}"),
                          //       trailing: TextButton(
                          //           onPressed: () {
                          //             _.sendJoinRequest(
                          //                 _.departmentsMember[index].id!);
                          //           },
                          //           child: Text("Leave",
                          //               style: TextStyle(color: Colors.red))),
                          //     ),
                          //     Divider()
                          //   ],
                          // );
                        }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
