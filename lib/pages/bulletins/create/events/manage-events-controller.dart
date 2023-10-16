import 'dart:math';

import 'package:churchappenings/api/bulletin.dart';
import 'package:get/get.dart';

class ManageEventsController extends GetxController {
  bool loading = true;
  late String bulletinId;
  late String bulletinName = '';
  final BulletinAPI api = BulletinAPI();
  var events = [];
  var deptEvents = [];

  onInit() async {
    bulletinId = Get.arguments['bulletinId'];
    bulletinName = Get.arguments['bulletinName'];
    await getEvents(bulletinId);
    await getDeptEvents();
    update();
    super.onInit();
  }

  Future getDeptEvents() async {
    loading = true;
    update();
    deptEvents = await api.getDeptsbyId(bulletinId);
    print('$deptEvents........dlk;sflskkkkkkkkkkkkkk');
    loading = false;
    update();
  }

  Future getEvents(String bulletinId) async {
    loading = true;
    update();
    events = await api.getEventsByBulletinId(bulletinId);
    loading = false;
    update();
  }
}
