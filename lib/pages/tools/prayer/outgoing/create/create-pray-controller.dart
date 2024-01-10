import 'package:churchappenings/api/pray.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePrayController extends GetxController {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get descController => _descController;

  bool anonymous = false;
  bool globalCommunity = false;
  bool localCommunity = false;

  handleOnChnageGCommunity(bool? value) {
    globalCommunity = value ?? false;
    update();
  }

  handleOnChnageAnonymus(bool? value) {
    anonymous = value ?? false;
    update();
  }

  handleOnChnageLocal(bool? value) {
    localCommunity = value ?? false;
    update();
  }

  Future createPrayerRequest() async {
    PrayAPI api = PrayAPI();

    await api.createPray(
      anonymous,
      globalCommunity,
      descController.text,
      titleController.text,
    );
  }
}
