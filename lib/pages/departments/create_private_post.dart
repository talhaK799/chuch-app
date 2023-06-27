import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/red-material-color.dart';
import '../../widgets/bottom-action-button.dart';
import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';
import 'departments-controller.dart';
import 'dumydata_screen.dart';

class CreatePrivatePost extends StatelessWidget {
  const CreatePrivatePost({super.key});

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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          navigateToWidget(),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Add New Post",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),

                      //! i work start here
                      SizedBox(height: 30),
                      _.imagePath != null
                          ? Container(
                              height: 200,
                              width: double.infinity,
                              child: Image.file(
                                File(
                                  _.imagePath!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          _.uploadEventImage();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: redColor),
                          ),
                          child: Center(
                            child: Text('Choose Image'),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Text(
                      //   "Title",
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //     height: 1.5,
                      //   ),
                      // ),
                      TextFormField(
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        controller: _.titleController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autocorrect: true,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        controller: _.descController,
                      ),

                      SizedBox(
                        height: 60,
                      ),
                      GestureDetector(
                        onTap: () {
                          _.addDummyData();
                          Get.to(
                            DumyScreen(
                              title: _.titleController.text,
                              des: _.descController.text,
                              file: _.imagePath.toString(),
                            ),
                            arguments: {'deptId': "27"},
                          );
                          log("DData:: ${_.dumyData}");
                          // _.savePrivatePost();
                          // Get.to(
                          //   ChatScreen(),
                          // );
                        },
                        child: buildBottomActionButton("Save"),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
