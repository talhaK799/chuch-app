import 'package:churchappenings/api/members.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteController extends GetxController {
  TextEditingController emailController = TextEditingController();

  MembersAPI api = MembersAPI();

  onSubmit() async {
    if (!emailController.text.isEmail) {
      Get.snackbar(
        'Validdation error',
        'Enter valid email',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      await api.inviteMembers(emailController.text);
    }
  }
}
