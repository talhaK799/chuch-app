import 'package:churchappenings/api/personal-event.dart';
import 'package:churchappenings/api/upload-image.dart';
import 'package:churchappenings/pages/tools/my-events/single/single-my-event-page.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:churchappenings/utils/time-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateMyEventController extends GetxController {
  String? selectedType;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool loading = false;
  bool buttonClicked = false;

  String? imagePath;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get descController => _descController;
  TextEditingController get dateController => _dateController;
  TextEditingController get timeController => _timeController;

  void selectType(String? value) {
    selectedType = value;
    update();
  }

  Future createPersonalEvent() async {
    loading = true;
    update();

    if (!buttonClicked) {
      if (titleController.text.length >= 3 &&
          selectedType != null &&
          dateController.text.length >= 3 &&
          timeController.text.length >= 3) {
        final dateAndTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        );
        buttonClicked = true;
        String uploadedImageUrl = await uploadImage(imagePath!);
        PersonalEventAPI api = PersonalEventAPI();
        String happeningId = await api.createPersonalEvent(
          title: titleController.text,
          description: descController.text,
          eventDateTime: dateAndTime,
          type: selectedType!,
          image: uploadedImageUrl,
        );

        Get.to(SingleMyEventPage(), arguments: {"happeningId": happeningId});
      }
    }

    loading = false;
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

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }
}
