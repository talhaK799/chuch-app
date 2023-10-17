import 'dart:developer';
import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/assignment.dart';
import 'package:churchappenings/pages/home/home-page.dart';
import 'package:churchappenings/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class AssignmentController extends GetxController {
  RxString assignmentType = 'Member'.obs;
  HtmlEditorController descController = HtmlEditorController();
  final ProfileAPI profileApi = ProfileAPI.to;
  Assginment assignment = Assginment();
  bool loading = false;
  bool isStandardAssignment = true;
  bool isPreConfirmed = false;
  List<String> selectedAssignees = [];
  List<int> selectedDeptIds = [];
  TextEditingController dateController = TextEditingController();
  TextEditingController assignController = TextEditingController();
  bool hint = false;
  var truncatedName;
  String? formattedDateTime;

  @override
  void onInit() async {
    assignment.assignmentType = "STANDARD";
    assignment.status = "PENDING";
    await getdepartments();
    await getDesignations();
    await gethintEmails("");
    // await BulletinAPI().addAssignmentDepartment(insrtdept);
    loading = false;
    update();
    super.onInit();
  }

  void setAssignmentType(String type) async {
    String name = await descController.getText();
    assignmentType.value = type;
    log('$type');
    update();
  }

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

  addMemAndDesigAssignments(context) async {
    loading = true;
    assignment.deptHappeningId = "hp-" +
        profileApi.selectedChurchId.toString() +
        "-" +
        DateTime.now().toString();
    assignment.description = await descController.getText();
    assignmentType.value = assignment.type!;
    if (!isStandardAssignment) {
      assignment.assignee = "";
      print(selectedAssignees.length);
      for (int i = 0; i < selectedAssignees.length; i++) {
        assignment.assignee = i == 0
            ? "${selectedAssignees[i]}"
            : "${assignment.assignee}, ${selectedAssignees[i]}";
      }
    }

    log('${assignment.datetime}');
    try {
      print("mem: ${assignment.toJson()}");
      await BulletinAPI().addMemberDesign(assignment);
      await BulletinAPI().assignMemDesig(assignment);
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
    assignment.deptHappeningId = "dhp-" +
        profileApi.selectedChurchId.toString() +
        "-" +
        DateTime.now().toString();
    formattedDateTime = assignment.datetime;
    log('$formattedDateTime}');
    if (!isStandardAssignment) {
      assignment.assignee = "";
      print(selectedAssignees.length);
      for (int i = 0; i < selectedAssignees.length; i++) {
        assignment.assignee = i == 0
            ? "${selectedAssignees[i]}"
            : "${assignment.assignee}, ${selectedAssignees[i]}";

        // assignment.deptid = i == 0
        //     ? ${selectedDeptIds[i]}
        //     : "${assignment.assignee}, ${selectedAssignees[i]}";
      }
    }
    assignment.description = await descController.getText();
    log('${assignment.description}');
    try {
      print(assignment.toJson());
      await BulletinAPI().addAssignmentDepartment(assignment);
      await BulletinAPI().assigndept(assignment);
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

  List<UserData> emailList = [];
  List<UserData> searchedEmails = [];
  late List<dynamic> response;

  gethintEmails(String v) async {
    // loading = true;

    response = await BulletinAPI().getHintsEmail();

    response.forEach((element) {
      emailList.add(UserData(email: element["email"], uuid: element["uuid"]));
    });
    // emailList = response.where((email) => email['email'].contains(v)).toList();
    loading = false;
    update();
  }

  searchByEmail(String value) {
    print(emailList.length);
    if (value.isEmpty) {
      hint = false;
    } else {
      hint = true;
      searchedEmails = emailList
          .where((e) => (e.email!.toLowerCase().contains(value.toLowerCase())))
          .toList();
      // emailList.where((email) => emailList.contains(value)).toList();
    }
    print(searchedEmails.length);
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

  selectAssignee(int index) {
    assignController.text = searchedEmails[index].email ?? "";
    assignment.assignee = searchedEmails[index].email ?? "";
    assignment.uuid = searchedEmails[index].uuid ?? "";
    if (!isStandardAssignment) {
      selectedAssignees.add(assignment.assignee ?? "");
      assignController.clear();
    }
    log('uuid: ${assignment.uuid}........');
    hint = false;
    update();
  }

  DateTime selectedDate = DateTime.now();
}

class UserData {
  String? email;
  String? uuid;

  UserData({this.email, this.uuid});
}
