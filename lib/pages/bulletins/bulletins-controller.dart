import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/permission.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BulletinsController extends GetxController {
  final ProfileAPI profileApi = ProfileAPI.to;
  final BulletinAPI api = BulletinAPI();
  final PermissionAPI permissionAPI = PermissionAPI();
  var bulletins = [];
  bool loading = true;
  bool isEditAccess = false;
  Logger log = Logger();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  // List<Bulletin> bulletin = [];

  @override
  void onInit() async {
    // await fetchBulletins();
    loading = false;

    // var res = await permissionAPI.getPermissions("FACILITY_BULLETIN");
    // isEditAccess = res["is_modify"];
    update();
    super.onInit();
  }

  Future fetchBulletins() async {
    bulletins = await api.getBulletins(profileApi.selectedChurchId);

    log.d(bulletins);
  }

  void showDatePickerDialog() async {
    final currentDate = DateTime.now();
    final initialDate = selectedDate.value ?? currentDate;

    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      // firstDate: currentDate,
      firstDate:
          DateTime(currentDate.year - 1), // Enable dates from one year ago

      lastDate: DateTime(currentDate.year + 1),
    );

    if (pickedDate != null && pickedDate != selectedDate.value) {
      print("OKK");

      selectedDate.value = pickedDate;
      String dateString = selectedDate.value.toString().substring(0, 10);
      print("Data: $dateString");
      getBulletinsByDate(dateString);
    }
  }

  void getBulletinsByDate(String date) async {
    bulletins = await api.fetchBulletinsByDate(date);
    update();
    // var json = jsonDecode(res);
    // res.forEach((value) {
    //   bulletin.add(Bulletin.fromJson(value));
    // });

    // print("check bulletin : ${bulletin[0].name}");
  }
}
