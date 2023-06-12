import 'package:churchappenings/utils/format-date-time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'single/single-my-event-page.dart';

Widget buildEventItem(dynamic event) {
  List<String> dateTime =
      formatDateTime(DateTime.parse(event["happening"]['date_time']));
  return GestureDetector(
    onTap: () {
      Get.to(SingleMyEventPage(),
          arguments: {"happeningId": event["happening"]['id']});
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dateTime[0],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event["happening"]["title"]),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateTime[1]),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
