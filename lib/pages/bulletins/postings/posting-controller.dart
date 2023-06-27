import 'dart:developer';

import 'package:churchappenings/api/bulletin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/check_permison.dart';

class PostingController extends GetxController {
  final BulletinAPI api = BulletinAPI();
  var departments;
  bool loading = true;
  late String selectedDepartment = '';
  late int selectedDepartmentId;
  late String bulletinId;
  var postings;
  final CheckPermission checkPermission = CheckPermission();

  TextEditingController _messageController = TextEditingController();
  TextEditingController get messageController => _messageController;

  List permission = [];

  @override
  void onInit() async {
    bulletinId = Get.arguments['bulletinId'];
    log("bulletinId $bulletinId");
    postings = await api.getPublicPostingBulletinById(bulletinId);
    print(postings);
    departments = await api.getEligiblePublicDepartment();
    loading = false;
    update();
    getcheckPermission(bulletinId);
    super.onInit();
  }

  void getcheckPermission(String depthId) async {
    loading = true;
    permission = await checkPermission.fetchDataForCheckPermsion();
    bool isRead = permission.firstWhere(
        (permission) =>
            permission['permission_id'] == 'DEPARTMENT_PUBLIC_POSTING',
        orElse: () => {})['is_modify'];
    loading = false;
    update();

    log("AAAAAAA:: $isRead");
    // log("AAA@@@ :${permission["permission_id"]["is_modify"].toString()}");
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
