import 'dart:io';

import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/my-events/create/create-my-event-controller.dart';
import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateMyEventPage extends StatelessWidget {
  final controller = Get.put(CreateMyEventController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<CreateMyEventController>(
            builder: (_) {
              if (_.loading)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(height: 10),
                        Text(
                          'Create Event',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'Create your personal event',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 30),
                        _.imagePath != null
                            ? Image.file(File(_.imagePath!))
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
                        SizedBox(height: 15),
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
                              'House warming',
                              'Birthday Party',
                              'House Blessing',
                              'Graduation party',
                              'Other',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _.selectedType,
                            elevation: 1,
                            onChanged: (value) => _.selectType(value),
                            hint: Text("Type of event"),
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
                                _.openDatePicker(context);
                              },
                              icon: Icon(
                                Icons.calendar_today,
                              ),
                            ),
                          ),
                          controller: _.dateController,
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
                                _.openTimePicker(context);
                              },
                              icon: Icon(
                                Icons.timer,
                              ),
                            ),
                          ),
                          controller: _.timeController,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            onTap: () => controller.createPersonalEvent(),
            child: buildBottomActionButton('Create Event'),
          ),
        ],
      ),
    );
  }
}
