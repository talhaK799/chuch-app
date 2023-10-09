import 'dart:developer';

import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class AssignmentController extends GetxController {
  RxString assignmentType = 'Member'.obs;
  HtmlEditorController descController = HtmlEditorController();
  bool loading = false;
  TextEditingController dateController = TextEditingController();
  void setAssignmentType(String type) {
    assignmentType.value = type;
    log('$type');
    update();
  }

  List<dynamic> dept = [];
  String? selecteddepartmentId;
  getdepartments() async {
    loading = true;
    List<dynamic> response = await BulletinAPI().getdepartments();

    dept = response;
    log('message $dept');

    loading = false;
    // Get.to(GuestBookScreen());

    update();
  }

  List<dynamic> desig = [];
  String? selecteddesignationId;
  getDesignations() async {
    loading = true;
    List<dynamic> response = await BulletinAPI().getDesignations();

    desig = response;
    log('message $desig');

    loading = false;
    // Get.to(GuestBookScreen());

    update();
  }

  @override
  void onInit() async {
    await getdepartments();
    await getDesignations();
    loading = false;
    update();
    super.onInit();
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
    update();
  }
}
