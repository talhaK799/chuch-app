import 'dart:developer';

import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/upload-image.dart';
import 'package:churchappenings/pages/bulletins/create/EditBulliten/assignment_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBulletingController extends GetxController {
  bool loading = false;
  bool buttonClicked = false;

  String? imagePath;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  var everyoneChecked = false.obs;
  var facilityMembersChecked = false.obs;
  var isDraft = false.obs;
  var isdraft = false;

  var onlyDepartmentChecked = false.obs;
  String permission = "";
  void toggleDraft(bool value) {
    isDraft.value = value;
    isdraft = value;
    log('message $value');
    update();
  }

  void toggleEveryone(bool newValue) {
    everyoneChecked.value = newValue;
    if (newValue) {
      facilityMembersChecked.value = false;
      permission = "EVERYONE";

      update();
    }
    log('$permission');
    update();
  }

  void toggleFacilityMembers(bool newValue) {
    facilityMembersChecked.value = newValue;
    if (newValue) {
      everyoneChecked.value = false;
      permission = "MEMBERS";
    }
    log('$permission');
    update();
  }

  Future createBulletin() async {
    loading = true;
    update();

    print(imagePath);

    String uploadedImageUrl = await uploadImage(imagePath!);
    BulletinAPI api = BulletinAPI();

    print(titleController.text +
        " || " +
        uploadedImageUrl +
        " || " +
        titleController.text +
        " || " +
        subtitleController.text +
        " || " +
        descriptionController.text);

    await api.createBulletin(
        titleController.text,
        uploadedImageUrl,
        subtitleController.text,
        descriptionController.text,
        permission,
        isdraft);
    loading = false;

    Get.back();
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }
}
