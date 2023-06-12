import 'package:churchappenings/pages/tools/pastor-search/book/pastor-book-appointment-controller.dart';
import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastorBookAppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PastorBookAppointmentController>(
        init: PastorBookAppointmentController(),
        global: false,
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(height: 10),
                        Text(
                          _.pastorName,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          _.churchName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(child: Text('Book a appointment')),
                        ),
                        SizedBox(height: 20),
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
                        TextFormField(
                          maxLines: 3,
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.addressController,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.phoneController,
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
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _.createAppointment();
                },
                child: buildBottomActionButton('Request a appointment'),
              ),
            ],
          );
        },
      ),
    );
  }
}
