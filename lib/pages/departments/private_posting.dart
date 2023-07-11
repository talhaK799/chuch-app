import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';
import 'create_private_post.dart';
import 'departments-controller.dart';

class PrivatePosting extends StatelessWidget {
  const PrivatePosting({super.key, required this.deptId});
  final String deptId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<DepartmentController>(
            init: DepartmentController(),
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
                    // Text('Data ${_.dumyData[0][0].toString()}'),
                    // Container(
                    //   height: 300,
                    //   child: ListView.builder(
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
                  ],
                ),
              );
            }));
  }
}
