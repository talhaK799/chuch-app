import 'dart:math';

import 'package:churchappenings/api/bulletin.dart';
import 'package:get/get.dart';

class ManageEventsController extends GetxController {
  bool loading = true;
  late String bulletinId;
  late String bulletinName = '';
  final BulletinAPI api = BulletinAPI();
  var standardEvents = [];
  var dynamicEvents = [];

  var deptEvents = [];
  var deptDynamicEvents = [];

  bool isStandardAssignment = true;

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
    deptEvents = await api.getDeptsbyId(bulletinId, "STANDARD");
    deptDynamicEvents = await api.getDeptsbyId(bulletinId, "DYNAMIC");

    print('$deptEvents........dlk;sflskkkkkkkkkkkkkk');
    loading = false;
    update();
  }

  Future getEvents(String bulletinId) async {
    loading = true;
    update();
    standardEvents = await api.getEventsByBulletinId(bulletinId, "STANDARD");
    dynamicEvents = await api.getEventsByBulletinId(bulletinId, "DYNAMIC");

    loading = false;
    update();
  }
}
