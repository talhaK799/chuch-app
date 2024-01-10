import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'create-pray-controller.dart';

class CreatePrayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<CreatePrayController>(
        init: CreatePrayController(),
        global: false,
        builder: (_) {
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          navigateToWidget(),
                          SizedBox(height: 10),
                          Text(
                            'Create request',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            'Church prayer request payers',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 50),
                          TextFormField(
                            autocorrect: true,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                            controller: _.titleController,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            maxLines: 3,
                            autocorrect: true,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            controller: _.descController,
                          ),
                          SizedBox(height: 30),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: redColor,
                                value: _.anonymous,
                                onChanged: (bool? value) {
                                  _.handleOnChnageAnonymus(value);
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Post as annonymus',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                    Text(
                                      'If selected, your name will not be displayed.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: redColor,
                                value: _.globalCommunity,
                                onChanged: (bool? value) {
                                  _.handleOnChnageGCommunity(value);
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Post in global community',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                    Text(
                                      'If selected, your pray will get posted outside your church.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: redColor,
                                value: _.localCommunity,
                                onChanged: (bool? value) {
                                  _.handleOnChnageLocal(value);
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Post in local community',
                                      style: TextStyle(fontSize: 17.0),
                                    ),
                                    Text(
                                      'If selected, your pray will get posted inside your church.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _.createPrayerRequest();
                  },
                  child: buildBottomActionButton('Create Prayer request'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
