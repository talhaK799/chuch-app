import 'dart:developer';

import 'package:churchappenings/api/bulletin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostingController extends GetxController {
  final BulletinAPI api = BulletinAPI();
  var departments;
  bool loading = true;
  late String selectedDepartment = '';
  late int selectedDepartmentId;
  late String bulletinId;
  var postings;

  TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  @override
  void onInit() async {
    bulletinId = Get.arguments['bulletinId'];
    log("bulletinId $bulletinId");
    postings = await api.getPublicPostingBulletinById(bulletinId);
    print(postings);
    departments = await api.getEligiblePublicDepartment();
    loading = false;
    update();

    super.onInit();
  }

  handleChangeDepartment(String value, int id) {
    selectedDepartment = value;
    selectedDepartmentId = id;
    update();
  }

  handleSubmit() async {
    await api.addPublicPosting(
      selectedDepartmentId,
      messageController.text,
      bulletinId,
    );
    postings = await api.getPublicPostingBulletinById(bulletinId);
    update();
  }
}
