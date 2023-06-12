import 'package:churchappenings/api/department.dart';
import 'package:churchappenings/models/department.dart';
import 'package:get/get.dart';

class DepartmentController extends GetxController {
  bool loading = true;
  DepartmentAPI departmentApi = DepartmentAPI();
  var response;
  List<Departments> departments = [];

  @override
  onInit() async {
    super.onInit();

    getMyDepartments();
  }

  getMyDepartments() async {
    await departmentApi.getDepartmentsYourMemberOff();
    response = await departmentApi.getAllDepartments();
    print(response);
    // for (int i = 0; i < response.length; i++) {
    //   departments.add(Departments.fromJson(response[i]));
    // }
    loading = false;
    update();
  }

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
