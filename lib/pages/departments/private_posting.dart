import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';
import 'chat.dart';
import 'create_private_post.dart';
import 'departments-controller.dart';

class PrivatePosting extends StatelessWidget {
  const PrivatePosting({required this.deptId});
  final String deptId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<DepartmentController>(
            init: DepartmentController("PrivatePostingScreen", true),
            global: false,
            builder: (_) {
              log("CHECK:: ${_.dumyData}");
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
                            Get.to(
                              CreatePrivatePost(),
                              arguments: {'deptId': deptId},
                            );
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
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.all(8),
                        shrinkWrap: true,
                        itemCount: _.getPrivatePosting.length,
                        itemBuilder: (BuildContext context, int index) {
                          final posting = _.getPrivatePosting[index];

                          return GestureDetector(
                            onTap: () {
                              // log("private id: ${posting["id"]}");
                              Get.to(
                                ChatScreen(
                                    privatePostId: posting["id"].toString()),
                                arguments: {
                                  'deptId': posting["id"].toString(),
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    posting['image'].toString(),
                                    width: double.infinity,
                                    // width: 80,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    posting['title'].toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    posting['description'].toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    posting['date_time'].toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
