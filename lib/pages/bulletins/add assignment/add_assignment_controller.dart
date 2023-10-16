import 'dart:developer';

import 'package:churchappenings/api/bulletin.dart';

import 'package:churchappenings/api/profile.dart';

import 'package:churchappenings/models/add_assignment_deparment.dart';
import 'package:churchappenings/pages/bulletins/create/add/add-bulletin-page.dart';
import 'package:churchappenings/pages/home/home-page.dart';

import 'package:churchappenings/utils/date-picker.dart';
import 'package:churchappenings/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class AssignmentController extends GetxController {
  RxString assignmentType = 'Member'.obs;
  HtmlEditorController descController = HtmlEditorController();
  final ProfileAPI profileApi = ProfileAPI.to;
  InsertDepartment insrtdept = InsertDepartment();
  bool loading = false;
  TextEditingController dateController = TextEditingController();
  TextEditingController assignController = TextEditingController();
  bool hint = false;
  void setAssignmentType(String type) async {
    String name = await descController.getText();
    assignmentType.value = type;
    log('$type');
    update();
  }

  String? formattedDateTime;
  Future<void> selectDateAndTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (pickedTime != null) {
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        formattedDateTime =
            DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").format(selectedDate);

        update();
      }
    }
  }

  addMemDesignationAssign(context) async {
    loading = true;
    insrtdept.deptHappeningId = "hp-" +
        profileApi.selectedChurchId.toString() +
        "-" +
        DateTime.now().toString();
    insrtdept.description = await descController.getText();
    assignmentType.value = insrtdept.type!;

    log('${insrtdept.description} description');
    log('${insrtdept.assignee} AASSigee');
    log('${insrtdept.type}type');
    log('${insrtdept.bulletinId}bulletin id');
    log('${insrtdept.uuid} uuid');
    log('${insrtdept.title} title');

    log('${insrtdept.datetime}');
    try {
      await BulletinAPI().addMemberDesign(insrtdept);
      await BulletinAPI().assignMemDesig(insrtdept);
      Get.to(HomePage());
      loading = false;
    } catch (e) {
      showSnackbar(
        context,
        message: 'SomeThing went wrong ',
      );
      loading = false;
    }
    loading = false;
    update();
  }

  addAssignmentDepartment(context) async {
    loading = true;
    insrtdept.deptHappeningId = "dhp-" +
        profileApi.selectedChurchId.toString() +
        "-" +
        DateTime.now().toString();
    formattedDateTime = insrtdept.datetime;
    log('$formattedDateTime}');

    insrtdept.description = await descController.getText();
    log('${insrtdept.description}');
    try {
      await BulletinAPI().addAssignmentDepartment(insrtdept);
      await BulletinAPI().assigndept(insrtdept);
      Get.to(HomePage());
      loading = false;
    } catch (e) {
      showSnackbar(
        context,
        message: 'SomeThing went wrong ',
      );
      loading = false;
    }
    loading = false;
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

  List<dynamic> emailList = [];
  List<dynamic> hintEmails = [];

  gethintEmails(String v) async {
    loading = true;
    List<dynamic> response = await BulletinAPI().getHintsEmail();

    hintEmails = response;
    emailList = response.where((email) => email['email'].contains(v)).toList();
    log('message $hintEmails');
    log('message $emailList');

    loading = false;
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

    await gethintEmails('kkk');

    // await BulletinAPI().addAssignmentDepartment(insrtdept);
    loading = false;
    update();
    super.onInit();
  }

  DateTime selectedDate = DateTime.now();

  // Future<void> selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (picked != null && picked != selectedDate) {
  //     selectedDate = picked;
  //   }
  //   update();
  // }
}
