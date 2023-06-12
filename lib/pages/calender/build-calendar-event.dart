import 'package:churchappenings/utils/format-date-time.dart';
import 'package:flutter/material.dart';

Widget buildCalendarEvent(dynamic event) {
  List<String> dateTime = formatDateTime(DateTime.parse(event['date_time']));
  return Column(
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
                  Text(event["title"]),
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
  );
}
