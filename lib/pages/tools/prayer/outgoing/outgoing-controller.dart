import 'package:churchappenings/api/pray.dart';
import 'package:get/get.dart';

import 'create/create-pray-page.dart';
import 'details/pray-details-page.dart';

class OutgoingController extends GetxController {
  PrayAPI api = PrayAPI();
  bool loading = true;
  dynamic _data = [];
  dynamic get data => _data;

  onInit() async {
    super.onInit();
    await fetchData();
    loading = false;
    update();
  }

  Future fetchData() async {
    _data = await api.getOwnPrays(0);
  }

  Future toggleIsAnswered(bool updateStatus, int id) async {
    loading = true;
    update();
    await api.togglePrayAsAnswered(!updateStatus, id);
    _data = await api.getOwnPrays(0);
    loading = false;
    update();
  }

  navigateToCreate() {
    Get.to(CreatePrayPage());
  }

  navigateToDetails(int id) {
    Get.to(PrayDetailsPage(), arguments: {"id": id});
  }
}
