import 'package:churchappenings/api/upload-image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePollController extends GetxController {
  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  TextEditingController addOption = TextEditingController();
  List<String> optionList = [];
  String? imagePath;

  String? selectedDropDownValue = "Text";
  List<String> dropDownItem = ["Text", "Image"];

  addOptioToList() {
    optionList.add(addOption.text.trim());
    addOption.clear();
    update();
    print(optionList.length);
  }

  changeDropDownValue(String value) {
    selectedDropDownValue = value;
    update();
  }

  removeItem(int index) {
    optionList.removeAt(index);
    update();
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }

  Future<void> showStartDatePickerDialog() async {
    final currentDate = DateTime.now();
    final initialDate = selectedStartDate.value ?? currentDate;

    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      // firstDate: currentDate,
      firstDate: currentDate
          .subtract(Duration(days: 0)), // Enable dates from one year ago

      lastDate: DateTime(currentDate.year + 1),
    );

    if (pickedDate != null && pickedDate != selectedStartDate.value) {
      print("OKK");

      selectedStartDate.value = pickedDate;
      String dateString = selectedStartDate.value.toString().substring(0, 10);
      print("Data: $dateString");
    }
  }

  void showEndDatePickerDialog() async {
    final currentDate = DateTime.now();
    final initialDate = selectedEndDate.value ?? currentDate;

    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      // firstDate: currentDate,
      firstDate: currentDate
          .subtract(Duration(days: 0)), // Enable dates from one year ago

      lastDate: DateTime(currentDate.year + 1),
    );

    if (pickedDate != null && pickedDate != selectedEndDate.value) {
      print("OKK");

      selectedEndDate.value = pickedDate;
      String dateString = selectedEndDate.value.toString().substring(0, 10);
      print("Data: $dateString");
    }
  }
}
