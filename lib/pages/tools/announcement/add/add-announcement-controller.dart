import 'package:churchappenings/api/announcement.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:churchappenings/utils/time-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddAnnouncementController extends GetxController {
  AnnouncementAPI api = AnnouncementAPI();

  String? selectedType;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool loading = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get descController => _descController;
  TextEditingController get dateController => _dateController;
  TextEditingController get timeController => _timeController;

  selectType(String? value) {
    selectedType = value;
    update();
  }

  Future openDatePicker(BuildContext context) async {
    selectedDate = await datePicker(context, selectedDate);
    dateController.text = DateFormat.yMMMd().format(selectedDate!).toString();
    update();
  }

  Future openTimePicker(BuildContext context) async {
    selectedTime = await timePicker(context, selectedTime);
    timeController.text = formatTime(selectedTime!);
    update();
  }

  Future createAnnouncement() async {
    if (titleController.text.length < 3 ||
        descController.text.length < 3 ||
        selectedType!.length < 0) return;

    final dateAndTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    await api.createAnnouncement(
      title: titleController.text,
      description: descController.text,
      type: selectedType!,
      dateTime: dateAndTime,
    );
  }
}
