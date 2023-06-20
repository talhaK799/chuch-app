import 'dart:developer';

import 'package:churchappenings/api/department.dart';
import 'package:churchappenings/models/department.dart';
import 'package:churchappenings/models/posting_.dart';
import 'package:get/get.dart';

class DepartmentController extends GetxController {
  bool loading = true;
  DepartmentAPI departmentApi = DepartmentAPI();
  var response;
  List<Departments> departments = [];
  List departmentsMember = [];
  // List<dynamic> deptPublicPosting = [];
  List<DeptPublicPosting> publicPosting = [];

  // DepartmentController(String id) {
  //   getPublicDepartment(id);
  // }

  @override
  onInit() async {
    super.onInit();
    getMyDepartments();
    // String deptId = Get.arguments['deptId'];
    getPublicDepartment(Get.arguments['deptId']);
  }

  getMyDepartments() async {
    var res = await departmentApi.getDepartmentsYourMemberOff();
    res.forEach((value) {
      departmentsMember.add(Departments.fromJson(value['department']));
    });
    update();
    response = await departmentApi.getAllDepartments();

    print("**** Response ==== >>> $response");
    for (int i = 0; i < response.length; i++) {
      departments.add(Departments.fromJson(response[i]["department"]));
    }
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
}
