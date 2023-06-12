import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/search-church.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/utils/time-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VisitChurchController extends GetxController {
  int facilityId = 0;
  String churchName = '';
  List<String> dateTimeStrings = [];
  var bulletins = [];

  BulletinAPI bulletinApi = BulletinAPI();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool loading = true;
  bool requestCallFromPastor = false;

  bool haveUpcomingVisit = false;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController churchAffliationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  SearchChurchAPI api = SearchChurchAPI();

  onInit() async {
    super.onInit();

    facilityId = Get.arguments["facilityId"];
    churchName = Get.arguments["churchName"];

    await checkIfAlreadyHaveVisitRequest();

    loading = false;
    update();
  }

  Future checkIfAlreadyHaveVisitRequest() async {
    var res = await api.checkForUpcomingVisit(facilityId);

    haveUpcomingVisit = res.length == 1;

    if (haveUpcomingVisit) {
      await fetchBulletins();
    }

    dateTimeStrings = haveUpcomingVisit
        ? formatDateTime(DateTime.parse(res[0]["date_of_visit"]))
        : [];
  }

  Future fetchBulletins() async {
    bulletins = await bulletinApi.getBulletins(facilityId);
    print(bulletins);
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

  handleChangeRequestCallFromPastor(bool? value) {
    requestCallFromPastor = value ?? false;
    update();
  }

  createVisitationRequest() async {
    final dateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );
    loading = true;
    update();

    await api.visitChurch(
      phoneNumber: phoneNumberController.text,
      age: int.parse(ageController.text),
      country: countryController.text,
      state: stateController.text,
      purpose: purposeController.text,
      dateTime: dateTime,
      requestCall: requestCallFromPastor,
      facilityId: facilityId,
      churchAffiliation: churchAffliationController.text,
    );

    await checkIfAlreadyHaveVisitRequest();

    loading = false;
    update();
  }
}
