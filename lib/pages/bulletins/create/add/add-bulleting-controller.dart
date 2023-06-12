import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/upload-image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBulletingController extends GetxController {
  bool loading = false;
  bool buttonClicked = false;

  String? imagePath;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

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

    await api.createBulletin(titleController.text, uploadedImageUrl,
        subtitleController.text, descriptionController.text);

    Get.back();
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }
}
