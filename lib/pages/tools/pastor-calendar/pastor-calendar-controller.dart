import 'package:churchappenings/api/pastor.dart';
import 'package:get/get.dart';

class PastorCalendarController extends GetxController {
  PastorAPI pastorAPI = PastorAPI();
  dynamic upcomingRequests;
  bool loading = true;

  void onInit() async {
    super.onInit();

    upcomingRequests = await pastorAPI.listUpcoming();

    loading = false;
    update();
  }
}
