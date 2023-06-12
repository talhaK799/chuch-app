import 'package:churchappenings/api/guestbook.dart';
import 'package:get/get.dart';

class SingleGuestController extends GetxController {
  dynamic data;
  final api = GuestBookAPI();
  bool loading = true;

  onInit() async {
    super.onInit();

    int id = Get.arguments["id"];
    data = await api.getSingleVisitationRequest(id);
    print(data);

    loading = false;
    update();
  }
}
