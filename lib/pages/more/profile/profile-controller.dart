import 'package:churchappenings/api/department.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/department.dart';
import 'package:churchappenings/pages/home/home-page.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/facility_member.dart';
import '../../../models/member_facility.dart';
import '../../../services/local_data.dart';

class ProfileController extends GetxController {
  bool loading = true;
  List<String> skills = [];
  var profileAPI = ProfileAPI.to;
  String selectedSkill = "None";
  String email = "None";
  DepartmentAPI departmentApi = DepartmentAPI();
  FacilityMemberApi facilityMember = FacilityMemberApi();
  var response;
  var facilityResponse;
  List<Departments> departments = [];
  List<MemberFacility> memberFacility = [];

  final localData = LocalData();
  String selectedCurch = '';

  int isEmployed = 0;
  int isUnemployed = 0;
  bool isNewJobNoti = false;
  String name = "";
  DateTime? selectedDate = DateTime.now();
  String employmentStatus = "Unemployed";
  bool isNotified = false;
  TextEditingController dateController = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    selectedCurch = await localData.getString('selected_church_name');
    var data = await profileAPI.getProfileData();
    var tempSkills = await profileAPI.getSkills();
    await getMyDepartments();
    await getMyFacilities();
    name = profileAPI.name;
    email = profileAPI.email;
    selectedDate = profileAPI.dob;
    if (data != null) {
      print(data);
      selectedSkill = data["occupation"] == null ? "None" : data["occupation"];
      isNewJobNoti =
          data["new_job_noti"] == null ? false : data["new_job_noti"];
      String employmentStatuss = data["emplymentStatus"] == null
          ? "Unemployed"
          : data["emplymentStatus"];
      if (employmentStatuss == "Unemployed") {
        isUnemployed = 1;
      } else {
        isEmployed = 1;
      }
      print("isEmployed => $isEmployed");

      dateController.text = DateFormat.yMMMd().format(selectedDate!).toString();
    }

    for (var i = 0; i < tempSkills.length; i++) {
      skills.add(tempSkills[i]["title"]);
    }
    loading = false;
    update();
  }

  onSave() async {
    print(employmentStatus);
    profileAPI.saveData(
        selectedDate!, selectedSkill, employmentStatus, isNewJobNoti);
  }

  getMyDepartments() async {
    response = await departmentApi.getDepartmentsYourMemberOff();
    // response = await departmentApi.getAllDepartments();
    print("**** Response ==== >>> $response");
    for (int i = 0; i < response.length; i++) {
      departments.add(Departments.fromJson(response[i]["department"]));
    }
    loading = false;
    update();
  }

  getMyFacilities() async {
    facilityResponse = await facilityMember.getMembersFacilities();
    // response = await departmentApi.getAllDepartments();
    print("**** facility Response ==== >>> $facilityResponse");
    for (int i = 0; i < facilityResponse.length; i++) {
      memberFacility
          .add(MemberFacility.fromJson(facilityResponse[i]["facility"]));
    }
    loading = false;
    update();
  }

  visitChurch(index) async {
    selectedCurch = memberFacility[index].name ?? '';

    await localData.setString(
        'selected_church_name', memberFacility[index].name ?? '');
    profileAPI.selectedChurchName = memberFacility[index].name ?? '';

    await localData.setInt('selected_church_id', memberFacility[index].id ?? 0);
    update();
    Get.offAll(
      HomePage(),
    );
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
