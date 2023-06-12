import 'package:churchappenings/api/members.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberTransferController extends GetxController {
  TextEditingController nameController = TextEditingController();

  MembersAPI api = MembersAPI();
  var churches = [];

  onSubmit() async {
    if (nameController.text.length < 3) {
      Get.snackbar('Validdation error', 'Enter 3 charaters minimum',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      churches = await api.getAllChurches(nameController.text);
      update();
    }
  }

  memberInvite(int id) async {
    await api.memberTransfer(id);
  }
}
