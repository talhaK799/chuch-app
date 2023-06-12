import 'package:churchappenings/api/bulletin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsibilityController extends GetxController {
  bool loading = true;
  var responsibility = [];
  String bulletinName = '';
  String bulletinId = '';

  TextEditingController assignedController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  BulletinAPI bulletinApi = BulletinAPI();

  onInit() async {
    bulletinId = Get.arguments['bulletinId'];
    bulletinName = Get.arguments['bulletinName'];
    responsibility = Get.arguments['responsibility'];
    loading = false;
    update();
    super.onInit();
  }

  addGroup() {
    responsibility.add({"members": [], "groupName": ''});
    update();
  }

  onChangeGroupName(int index, String value) {
    responsibility[index]['groupName'] = value;
    update();
  }

  removeGroup(int index) {
    responsibility.removeAt(index);
    update();
  }

  addMemberRow(int index) {
    if (nameController.text != '' && assignedController.text != '') {
      responsibility[index]['members'].add({
        "member": nameController.text,
        "assignedAs": assignedController.text
      });

      nameController.text = '';
      assignedController.text = '';
    }
    update();
  }

  removeMember(int groupIndex, int memberIndex) {
    responsibility[groupIndex]['members'].removeAt(memberIndex);
    update();
  }

  onSave() async {
    loading = true;
    await bulletinApi.addResponsibility(bulletinId, responsibility);
    Get.back();
    loading = false;
    update();
  }
}
