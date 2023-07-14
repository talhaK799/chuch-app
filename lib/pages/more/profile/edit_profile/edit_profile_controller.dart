import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/member-of.dart';
import '../../../../services/local_data.dart';

class EditProfileController extends GetxController {
  bool loading = true;
  List<String> skills = [];
  var profileAPI = ProfileAPI.to;
  String selectedSkill = "None";
  int isEmployed = 0;
  int isUnemployed = 0;
  bool isNewJobNoti = false;
  String name = "";
  DateTime? selectedDate = DateTime.now();
  String employmentStatus = "Unemployed";
  bool isNotified = false;
  TextEditingController dateController = TextEditingController();
  List<Member> churches = [];
  int selectedChurch = 9999999;
  final ProfileAPI profileApi = ProfileAPI.to;
  Member? selectedChurchObj;
  final localData = LocalData();

  @override
  onInit() async {
    super.onInit();

    var data = await profileAPI.getProfileData();
    var tempSkills = await profileAPI.getSkills();
    churches = profileApi.churches;
    selectedChurch = profileApi.selectedChurchId;
    for (int i = 0; i < churches.length; i++) {
      if (selectedChurch == churches[i].id) {
        selectedChurchObj = churches[i];
      }
    }

    print(data);
    selectedSkill = data["occupation"] == null ? "None" : data["occupation"];
    isNewJobNoti = data["new_job_noti"] == null ? false : data["new_job_noti"];
    String employmentStatuss = data["emplymentStatus"] == null
        ? "Unemployed"
        : data["emplymentStatus"];
    if (employmentStatuss == "Unemployed") {
      isUnemployed = 1;
    } else {
      isEmployed = 1;
    }
    print("isEmployed => $isEmployed");
    name = data != null && data["user"] != null && data["user"]["name"] != null
        ? data["user"]["name"]
        : "Ali Khan";
    if (data != null &&
        data["user"] != null &&
        data["user"]["birthdate"] != null) {
      selectedDate = DateTime.parse(data["user"]["birthdate"]);
    } else {
      print("no data");
    }

    // name = data["user"]["name"] != null ? data["user"]["name"] : "Ali Khan";
    // data["user"]["birthdate"] != null
    //     ? selectedDate = DateTime.parse(data["user"]["birthdate"])
    //     : print("no data");
    dateController.text = DateFormat.yMMMd().format(selectedDate!).toString();

    for (var i = 0; i < tempSkills.length; i++) {
      skills.add(tempSkills[i]["title"]);
    }
    loading = false;
    update();
  }

  updateSelectedChurch(int churchId) {
    print(churchId);
    localData.setInt("selected_church_id", churchId);
    selectedChurch = churchId;
    update();
  }

  onSave() async {
    print(employmentStatus);
    profileAPI.saveData(
        selectedDate!, selectedSkill, employmentStatus, isNewJobNoti);
  }

  void onChangeSelectedSkill(String? value) {
    selectedSkill = value!;
    update();
  }

  Future openDatePicker(BuildContext context) async {
    selectedDate = await datePicker(context, selectedDate);
    dateController.text = DateFormat.yMMMd().format(selectedDate!).toString();
    update();
  }

  onUpdateEmployment(isEmployed) {
    this.isEmployed = isEmployed;
    if (this.isEmployed == 1) {
      employmentStatus = "Employed";
      this.isUnemployed = 0;
    } else {
      employmentStatus = "Unemployed";
      this.isUnemployed = 1;
      isNewJobNoti = false;
    }
    print(isEmployed);
    update();
  }

  updateNewJobNoti() {
    isNewJobNoti = !isNewJobNoti;
    update();
  }
}
