import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<TimeOfDay?> timePicker(
  BuildContext context,
  TimeOfDay? selectedTime,
) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime != null ? selectedTime : TimeOfDay.now(),
  );
  return picked;
}

String formatTime(TimeOfDay tod) {
  final now = new DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
  final format = DateFormat.jm(); //"6:00 AM"
  return format.format(dt);
}
