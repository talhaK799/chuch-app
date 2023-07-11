import 'dart:developer';

import 'package:churchappenings/api/department.dart';
import 'package:churchappenings/models/department.dart';
import 'package:churchappenings/models/posting_.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/private_posting.dart';
import '../../api/upload-image.dart';
import '../../models/private_posting.dart';

class DepartmentController extends GetxController {
  PrivatePostingApi privatePostingApi = PrivatePostingApi();
  PrivatePostingModel privatePostingModel = PrivatePostingModel();
  bool loading = true;
  DepartmentAPI departmentApi = DepartmentAPI();
  var response;
  List<Departments> departments = [];
  List departmentsMember = [];
  // List<dynamic> deptPublicPosting = [];
  List<DeptPublicPosting> publicPosting = [];
  List dumyData = [];

  String? imagePath;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get descController => _descController;

  // DepartmentController(String id) {
  //   getPublicDepartment(id);
  // }

  @override
  onInit() async {
    super.onInit();
    getMyDepartments();
    // String deptId = Get.arguments['deptId'];
    if (Get.arguments != null && Get.arguments['deptId'] != null) {
      getPublicDepartment(Get.arguments['deptId']);
    }
  }

  getMyDepartments() async {
    var res = await departmentApi.getDepartmentsYourMemberOff();
    res.forEach((value) {
      departmentsMember.add(Departments.fromJson(value['department']));
    });
    update();

    var result = response = await departmentApi.getAllDepartments();

    // print("**** Response ==== >>> $response");
    // res.forEach((value) {
    //   departments.add(Departments.fromJson(response["department"]));
    // });
    // for (int i = 0; i < response.length; i++) {
    //   departments.add(Departments.fromJson(response[i]["department"]));
    // }
    loading = false;
    update();
  }

  getPublicDepartment(String deptId) async {
    deptId = Get.arguments['deptId'];

    publicPosting = [];
    var res = await departmentApi.getPublicDepartment(deptId);

    res.forEach((element) {
      publicPosting.add(DeptPublicPosting.fromJson(element));
    });
    update();

    log("get posting data ${publicPosting.length}");

    // res.then((value) {
    //   // Access the data returned by the query
    //   deptPublicPosting = value;
    //   // int id = deptPublicPosting[1]["id"];
    //   // String message = deptPublicPosting[0]["message"];
    //   // String senderName = deptPublicPosting[0]["sender_name"];
    //   // String bulletinName = deptPublicPosting[0]["bulletin"]["name"];
    //   // String bulletinImage = deptPublicPosting[0]["bulletin"]["image"];
    //   // String bulletinSubtitle = deptPublicPosting[0]["bulletin"]["subtitle"];
    //   // log("aa:$id");
    // });
  }

  // getDepartmentsMember() async {
  //   var res = await departmentApi.getDepartmentsYourMemberOff();
  //   res.
  // }

  sendJoinRequest(int deptId) async {
    loading = true;
    update();

    await departmentApi.deptJoinRequest(deptId);
    Get.snackbar("Success", "Department join request sent successfully",
        snackPosition: SnackPosition.BOTTOM);
    loading = false;
    update();
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }

  Future savePrivatePost() async {
    String deptId = Get.arguments['deptId'];
    log("aa22 $deptId");
    String uploadedImageUrl = await uploadImage(imagePath!);
    privatePostingApi.createPrivatePosting(
      title: titleController.text,
      description: descController.text,
      image: uploadedImageUrl,
      deptId: deptId,
    );

    // privatePostingModel.title = titleController.text;
    // privatePostingModel.image = uploadedImageUrl;
    // privatePostingModel.description = descController.text;
    // privatePostingModel.senderId = senderId;
    // privatePostingModel.senderName = senderName;
    // privatePostingModel.senderDept = deptId;
  }

  addDummyData() {
    dumyData.add({titleController.text, descController.text, imagePath});
    update();
  }
}
