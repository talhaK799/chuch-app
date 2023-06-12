import 'package:churchappenings/api/jobs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostJobsController extends GetxController {
  bool membersOnly = true;
  bool loading = false;

  final jobsAPI = JobsAPI();

  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  setMembersOnly(bool? value) {
    membersOnly = value ?? false;
    update();
  }

  postAJob() async {
    await jobsAPI.postJob(
      titleController.text,
      locationController.text,
      companyController.text,
      phoneNumberController.text,
      descController.text,
      membersOnly,
      linkController.text,
    );
  }
}
