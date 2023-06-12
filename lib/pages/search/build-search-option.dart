import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

Expanded buildSearchByOption(
  String title,
  String activeSearchBy,
  Function handleSubMenuTap,
) {
  bool active = false;

  if (title == activeSearchBy) {
    active = true;
  }

  return Expanded(
    child: GestureDetector(
      onTap: () {
        handleSubMenuTap(title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: active ? redColor : Color.fromRGBO(255, 240, 240, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : redColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}
