import 'package:churchappenings/api/pastor.dart';
import 'package:churchappenings/utils/time-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PastorBookAppointmentController extends GetxController {
  PastorAPI pastorAPI = PastorAPI();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool loading = true;
  int pastorId = 0;
  String pastorName = '';
  String churchName = '';
  dynamic daysAvailibility = {};

  TextEditingController _descController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  TextEditingController get descController => _descController;
  TextEditingController get addressController => _addressController;
  TextEditingController get phoneController => _phoneController;
  TextEditingController get dateController => _dateController;
  TextEditingController get timeController => _timeController;

  onInit() async {
    super.onInit();

    pastorId = Get.arguments['pastorId'];
    pastorName = Get.arguments["pastorName"];
    churchName = Get.arguments["churchName"];

    var data = await pastorAPI.getPastorAvailibility(pastorId);
    daysAvailibility = data["availibility"];
    print(daysAvailibility);

    loading = false;
    update();
  }

  Future openDatePicker(BuildContext context) async {
    DateTime initialDate = (selectedDate ?? DateTime.now());
    selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        selectableDayPredicate: decideWhichDayToEnable);
    dateController.text = DateFormat.yMMMd().format(selectedDate!).toString();
    update();
  }

  Future openTimePicker(BuildContext context) async {
    selectedTime = await timePicker(context, selectedTime);
    timeController.text = formatTime(selectedTime!);
    update();
  }

  bool decideWhichDayToEnable(DateTime day) {
    DateTime now = new DateTime.now();
    if (daysAvailibility[DateFormat('EEEE').format(day)])
      return true;
    else if (day == DateTime(now.year, now.month, now.day))
      return true;
    else
      return false;
  }

  Future createAppointment() async {
    final dateAndTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    await pastorAPI.createAppointment(
      descController.text,
      addressController.text,
      phoneController.text,
      dateAndTime,
      pastorId,
    );
  }
}
