import 'package:churchappenings/api/attendance.dart';
import 'package:get/get.dart';

class AttendaceController extends GetxController {
  bool loading = true;
  // bool isSearching = false;

  var response;
  AttendanceAPI attendanceAPI = AttendanceAPI();
  List<DateTime> presentDates = [];

  onInit() async {
    super.onInit();
    await getAttendances();
    loading = false;
    update();
  }

  getAttendances() async {
    response = await attendanceAPI.getAttendance();
    print("**** Response ==== >>> $response");
    for (int i = 0; i < response.length; i++) {
      var d = DateTime.parse(
        response[i]['date'],
      ).toUtc();
      presentDates.add(d);
      print('date===> $d');
    }
    print('presentslist length===>${presentDates.length}');
    loading = false;
    update();
  }

  takeAttendance() async {
   await attendanceAPI.takeAttendance();
  }
}
