import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsibilitiesController extends GetxController {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController memberNameController = TextEditingController();
  final TextEditingController assignedAsController = TextEditingController();
  final RxList<Map<String, String>> members = <Map<String, String>>[].obs;
final bool loading = false;
  void addMember() {
    final memberName = memberNameController.text;
    final assignedAs = assignedAsController.text;

    if (memberName.isNotEmpty && assignedAs.isNotEmpty) {
      members.add({'member': memberName, 'assignedAs': assignedAs});
      memberNameController.clear();
      assignedAsController.clear();
    }
    update();
  }

  void submit() {
    final groupName = groupNameController.text;

    if (groupName.isNotEmpty && members.isNotEmpty) {
   
      print('Group Name: $groupName');
      print('Members: $members');
    }
    update();
  }

  @override
  void onClose() {
    groupNameController.dispose();
    memberNameController.dispose();
    assignedAsController.dispose();
    super.onClose();
  }
}
