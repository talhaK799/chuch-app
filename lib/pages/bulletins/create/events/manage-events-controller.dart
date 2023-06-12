import 'package:churchappenings/api/bulletin.dart';
import 'package:get/get.dart';

class ManageEventsController extends GetxController {
  bool loading = true;
  late String bulletinId;
  late String bulletinName = '';
  final BulletinAPI api = BulletinAPI();
  var events = [];

  onInit() async {
    bulletinId = Get.arguments['bulletinId'];
    bulletinName = Get.arguments['bulletinName'];
    await getEvents(bulletinId);

    super.onInit();
  }

  Future getEvents(String bulletinId) async {
    loading = true;
    update();
    events = await api.getEventsByBulletinId(bulletinId);
    loading = false;
    update();
  }
}
