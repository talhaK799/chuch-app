import 'dart:developer';

import 'package:churchappenings/api/guestbook.dart';
import 'package:churchappenings/models/add_guestbook.dart';
import 'package:get/get.dart';

import 'single-guest/single-guest-page.dart';

class GuestBookController extends GetxController {
  List list = [];
  bool loading = true;
  bool havePermissionToViewDetails = false;
  final api = GuestBookAPI();
  GuestBookInputModel addguestm = GuestBookInputModel();
  List<GuestBookInputModel>? guestData;
  onInit() async {
    super.onInit();

    //  await checkPermission();
    // await getUpcomingGuestList();
    await getGuestData();
    
    loading = false;
    update();
  }

  checkPermission() async {
    havePermissionToViewDetails = true;
  }

  getGuestData() async {

    guestData = await api.getGuestData();
    
    log('listtttt$guestData');
    loading = false;
    update();
   
  }

  getUpcomingGuestList() async {
    // guestData = await api.getUpcomingGuestList();
    // //  guestData = response;
    // log('listtttt$guestData');
    update();
  }

  navigateToDetails(int id) {
    Get.to(SingleGuestPage(), arguments: {"id": id});
  }
}
