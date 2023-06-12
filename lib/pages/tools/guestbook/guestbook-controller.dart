import 'package:churchappenings/api/guestbook.dart';
import 'package:get/get.dart';

import 'single-guest/single-guest-page.dart';

class GuestBookController extends GetxController {
  List list = [];
  bool loading = true;
  bool havePermissionToViewDetails = false;
  final api = GuestBookAPI();

  onInit() async {
    super.onInit();

    await checkPermission();
    await getUpcomingGuestList();

    loading = false;
    update();
  }

  checkPermission() async {
    havePermissionToViewDetails = true;
  }

  getUpcomingGuestList() async {
    list = await api.getUpcomingGuestList();
  }

  navigateToDetails(int id) {
    Get.to(SingleGuestPage(), arguments: {"id": id});
  }
}
