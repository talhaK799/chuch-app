import 'package:flutter/material.dart';

Future<DateTime?> datePicker(
  BuildContext context,
  DateTime? selectedDate,
) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate : DateTime.now(),
      firstDate: DateTime(1930, 8),
      lastDate: DateTime(2101));
  return picked;
}
