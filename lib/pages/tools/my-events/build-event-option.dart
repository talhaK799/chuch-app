import 'package:flutter/material.dart';

Widget buildEventOption(
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
            color: active ? Colors.black : Colors.grey,
            fontWeight: FontWeight.w700,
            fontSize: active ? 19 : 16,
          ),
        ),
      ),
    ),
  );
}
