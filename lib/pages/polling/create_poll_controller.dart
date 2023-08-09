import 'package:churchappenings/api/poll.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/api/upload-image.dart';
import 'package:churchappenings/models/creat_poll.dart';
import 'package:churchappenings/models/dept.dart';
import 'package:churchappenings/models/pemission.dart';
import 'package:churchappenings/models/poll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:logger/logger.dart';

class CreatePollController extends GetxController {
  final log = Logger();

  final ProfileAPI profileApi = ProfileAPI.to;
  Rx<DateTime?> selectedStartDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedEndDate = Rx<DateTime?>(null);
  Rx<TimeOfDay?> selectedTime = Rx<TimeOfDay?>(null);
  TextEditingController addOption = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  HtmlEditorController descController = HtmlEditorController();
  List<String> optionList = [];
  List<Option> optionList1 = [];
  PollAPI pollapi = PollAPI();
  CreatePoll poll = CreatePoll();
  String? imagePath;
  String? uploadedImageUrl;

  String? selectedDropDownValue = "text";
  List<String> dropDownItem = ["text", "image"];

  CreatePollController() {
    getDeptList();
    isChange(permissions[0].isCheckBox == true ? false : true, 0);
  }

  addOptioToList() {
    if (addOption.text.isNotEmpty) {
      optionList.add(addOption.text.trim());
    }
    addOption.clear();
    update();
  }

  convertOptionToList() {
    for (int i = 0; i < optionList.length; i++) {
      optionList1.add(Option(id: i, option: optionList[i]));
    }
    update();
  }

  changeDropDownValue(String value) {
    selectedDropDownValue = value;
    update();
  }

  removeItem(int index) {
    optionList.removeAt(index);
    update();
  }

  // String? desc;
  createpoll() async {
    await convertOptionToList();
    poll.facilityId = profileApi.selectedChurchId;
    poll.options = optionList1;
    poll.type = selectedDropDownValue;
    poll.title = titleController.text.trim();
    poll.desc = await descController.getText();

    await pollapi.createPoll(poll);
    clearController();
    Get.back();

    Get.back();

    update();
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }

  Future<void> uploadImageToServer() async {
    optionList = [];
    uploadedImageUrl = await uploadImage(imagePath!);
    if (uploadedImageUrl != null) {
      optionList.add(uploadedImageUrl!);
    }
    update();
  }

  Future<void> showStartDatePickerDialog() async {
    final currentDate = DateTime.now();
    final initialDate = selectedStartDate.value ?? currentDate;
    final initialTime = TimeOfDay(
      hour: currentDate.hour,
      minute: currentDate.minute,
    );

    ///Time picker
    final pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: initialDate,
      // firstDate: currentDate,
      firstDate: currentDate
          .subtract(Duration(days: 0)), // Enable dates from one year ago

      lastDate: DateTime(currentDate.year + 1),
    );
    final pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: initialTime,
      // firstDate: currentDate,
      // firstTime: currentDate
      //     .subtract(Duration(days: 0)), // Enable dates from one year ago

      // lastDate: DateTime(currentDate.year + 1),
    );

    if ((pickedDate != null && pickedDate != selectedStartDate.value) &&
        (pickedTime != null && pickedTime != selectedTime.value)) {
      print("OKK");

      selectedStartDate.value = pickedDate;
      selectedTime.value = pickedTime;
      final newDateTime = DateTime(
          selectedStartDate.value!.year,
          selectedStartDate.value!.month,
          selectedStartDate.value!.day,
          selectedTime.value!.hour,
          selectedTime.value!.minute);
      String dateString = selectedStartDate.value.toString().substring(0, 10);
      print("Data: $dateString");
      poll.startDate = newDateTime;
    }
    update();
  }

  // void showEndDatePickerDialog() async {
  //   final currentDate = DateTime.now();
  //   final initialDate = selectedEndDate.value ?? currentDate;

  //   final pickedDate = await showDatePicker(
  //     context: Get.context!,
  //     initialDate: initialDate,
  //     // firstDate: currentDate,
  //     firstDate: currentDate
  //         .subtract(Duration(days: 0)), // Enable dates from one year ago
  //     lastDate: DateTime(currentDate.year + 1),
  //   );

  //   if (pickedDate != null && pickedDate != selectedEndDate.value) {
  //     selectedEndDate.value = pickedDate;

  //     String dateString = selectedEndDate.value.toString().substring(0, 10);
  //     print("Data: $dateString");
  //   }
  // }

  void clearController() {
    titleController.clear();
    descController.clear();
    optionList.clear();
    selectedDropDownValue = "Text";
    selectedStartDate.value = null;
    selectedEndDate.value = null;
    poll = CreatePoll();
    optionList1.clear();
    update();
  }

  //////******************************************** */
  ///Polling permission controller
  ///*********************************************** */
  List<Dept> deptList = [];
  Permission permission = Permission();

  List<Permission> permissions = [
    Permission(
        title: "Everyone",
        isRead: true,
        isCheckBox: false,
        isShow: false,
        isModify: false),
    Permission(
        title: "Facility Members",
        isRead: true,
        isModify: false,
        isCheckBox: false,
        isShow: false),
    Permission(
        title: "Only Department",
        isRead: true,
        isShow: false,
        isModify: false,
        isCheckBox: false),
  ];

  isChange(bool val, int index) {
    for (int i = 0; i < permissions.length; i++) {
      if (i == index) {
        permissions[i].isCheckBox = val;
        permissions[i].isShow = val;
      } else {
        permissions[i].isCheckBox = false;
        permissions[i].isShow = false;
      }
    }
    update();
  }

  selectPermisionIsModify() {
    for (int i = 0; i < permissions.length; i++) {
      if (permissions[i].isCheckBox == true) {
        if (permissions[i].isModify == true) {
          permissions[i].isModify = false;
        } else {
          permissions[i].isModify = true;
        }
      } else {
        permissions[i].isModify = false;
      }
    }
    update();
  }

  Future getDeptList() async {
    var res = await pollapi.getDepts(profileApi.selectedChurchId);
    if (res?["data"]["department"] != null) {
      List<dynamic> data = res["data"]["department"];
      deptList = data.map((dept) => Dept.fromJson(dept)).toList();
    }

    update();
  }

  addPermission() {
    for (int i = 0; i < permissions.length; i++) {
      if (permissions[i].isCheckBox == true) {
        print(permissions[i].toJson());
      }
    }
  }

  isChangeDept(bool val, int index) {
    for (int i = 0; i < deptList.length; i++) {
      deptList[index].isSelect = val;
      print(deptList[index].isSelect);
    }

    update();
  }

  Future<void> createPollPermission() async {
    for (int i = 0; i < permissions.length; i++) {
      if (permissions[i].title == "Everyone" &&
          permissions[i].isCheckBox == true) {
        permission.title = "EVERYONE";
        permission.isModify = permissions[i].isModify;
        permission.isRead = permissions[i].isRead;
      }
      if (permissions[i].title == "Facility Members" &&
          permissions[i].isCheckBox == true) {
        permission.title = "ONLYFACILITYMEM";
        permission.isModify = permissions[i].isModify;
        permission.isRead = permissions[i].isRead;
      }
      if (permissions[i].title == "Only Department" &&
          permissions[i].isCheckBox == true) {
        List<int> depdtId = [];
        for (int i = 0; i < deptList.length; i++) {
          if (deptList[i].isSelect == true) {
            depdtId.add(deptList[i].id!);
          }
        }
        permission.departmentsId = depdtId.join(",");
        permission.title = "ONLYDEPTMEM";
        permission.isModify = permissions[i].isModify;
        permission.isRead = permissions[i].isRead;
      }
    }
    var res = await pollapi.creaPermission(permission);
    int id = res["data"]["insert_poll_permissions"]["returning"][0]["id"];

    if (id.toString().isNotEmpty) {
      poll.permissionId = id;
      createpoll();
    }
    print(res);

    permission = Permission();

    update();
  }
}
