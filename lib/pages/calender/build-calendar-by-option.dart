import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

Widget buildCalendarByOption(
  String title,
  String activeCalendarBy,
  Function handleSubMenuTap,
) {
  bool active = false;

  if (title == activeCalendarBy) {
    active = true;
  }

  return GestureDetector(
    onTap: () {
      handleSubMenuTap(title);
    },
    child: Container(
      decoration: BoxDecoration(),
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: active ? redColor : Colors.grey,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    ),
  );
}
