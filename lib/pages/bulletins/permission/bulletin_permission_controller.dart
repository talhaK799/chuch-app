import 'dart:developer';

import 'package:churchappenings/api/poll.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/dept.dart';
import 'package:get/get.dart';

class BulletinPermissionController extends GetxController {
  List<Dept> deptList = [];
  final ProfileAPI profileApi = ProfileAPI.to;

  PollAPI pollapi = PollAPI();

  var everyoneChecked = false.obs;
  var facilityMembersChecked = false.obs;
  var onlyDepartmentChecked = false.obs;
  var showSubCheckboxes = false.obs;
 
  void toggleEveryone(bool newValue) {
    everyoneChecked.value = newValue;
    if (newValue) {
      
      facilityMembersChecked.value = false;
      onlyDepartmentChecked.value = false;
      showSubCheckboxes.value = false;
    }
    update();
  }

 
  void toggleFacilityMembers(bool newValue) {
    facilityMembersChecked.value = newValue;
    if (newValue) {
   
      everyoneChecked.value = false;
      onlyDepartmentChecked.value = false;
      showSubCheckboxes.value = false;
    }
    update();
  }

 
  void toggleOnlyDepartment(bool newValue) {
    onlyDepartmentChecked.value = newValue;
    if (newValue) {
     
      everyoneChecked.value = false;
      facilityMembersChecked.value = false;
      showSubCheckboxes.value = true;
    }
    update();
  }

  onInit() async {
    getDeptList();
    update();
  }

  isChangeDept(bool val, int index) {
    for (int i = 0; i < deptList.length; i++) {
      deptList[index].isSelect = val;
      print(deptList[index].isSelect);
    }

    update();
  }

  Future getDeptList() async {
    var res = await pollapi.getDepts(profileApi.selectedChurchId);
    log('res........$res');
    if (res?["data"]["department"] != null) {
      List<dynamic> data = res["data"]["department"];
      deptList = data.map((dept) => Dept.fromJson(dept)).toList();
    }

    update();
  }
}
