import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';
import 'departments-controller.dart';

class DumyScreen extends StatelessWidget {
  const DumyScreen(
      {super.key, required this.title, required this.des, required this.file});
  final String title, des;
  final String file;
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
              return Padding(
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
                              // Get.to(
                              //   CreatePrivatePost(),
                              //   arguments: {'deptId': deptId},
                              // );
                            },
                            child: Text(
                              "Create Post",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Text(
                        "Private Posting",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 30),

                      // Container(
                      //   height: 300,
                      //   child: ListView.builder(s
                      //     itemCount: _.dumyData.length,
                      //     itemBuilder: (context, index) {
                      //       final item = _.dumyData[
                      //           index]; // Accessing individual item from the data list

                      //       return ListTile(
                      //         title: Text(item),
                      //         // Add any other desired widgets or customization for each list item
                      //       );
                      //     },
                      //   ),
                      // ),

                      Container(
                        width: double
                            .infinity, // Adjust the width as per your requirements
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 4.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.file(
                              File(
                                file,
                              ),
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              children: [
                                Text(
                                  'Title: ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.0),
                            Row(
                              children: [
                                Text(
                                  'Description: ',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                Text(
                                  des,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ));
            }));
  }
}
