import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:get/get.dart';

import 'add-announcement-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';

class AddAnnouncementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<AddAnnouncementController>(
        init: AddAnnouncementController(),
        global: false,
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(height: 10),
                        Text(
                          'Create',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'Church announcements',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                          ),
                          controller: controller.titleController,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          maxLines: 3,
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          controller: controller.descController,
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: DropdownButton<String>(
                            items: <String>[
                              'INFO',
                              'IMPORTANT',
                              'ALERT',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: controller.selectedType,
                            elevation: 1,
                            onChanged: (value) => controller.selectType(value),
                            hint: Text("Type of announcement"),
                            isExpanded: true,
                            underline: SizedBox(),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.openDatePicker(context);
                              },
                              icon: Icon(
                                Icons.calendar_today,
                              ),
                            ),
                          ),
                          controller: controller.dateController,
                          readOnly: true,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Time',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.openTimePicker(context);
                              },
                              icon: Icon(
                                Icons.timer,
                              ),
                            ),
                          ),
                          controller: controller.timeController,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.createAnnouncement(),
                child: buildBottomActionButton('Create Announcement'),
              ),
            ],
          );
        },
      ),
    );
  }
}
