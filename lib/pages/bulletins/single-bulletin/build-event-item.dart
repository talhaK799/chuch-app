import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

Container buildEventItem({
  required String title,
  required String assignedTo,
  required String time,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          width: 2,
          color: redColor,
        ),
      ),
    ),
    child: ListTile(
      title: Text(title),
      subtitle: Text(assignedTo),
      trailing: Text(time),
    ),
  );
}
