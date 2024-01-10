import 'package:churchappenings/api/pray.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/comment.dart';
import 'outgoing/outgoing-page.dart';

class PrayerContoller extends GetxController {
  PrayAPI api = PrayAPI();
  double score = 0.0;

  Rx<bool> isall = true.obs;
  Rx<bool> isPray = false.obs;

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    score = await api.getPrayrometerData();
    update();
  }

  List<Comments> filedata = [
    Comments(
      userName: 'Chuks Okwuenu',
      userImage: 'https://picsum.photos/300/30',
      message: 'I love to code',
      date: '2021-01-01 12:00:00',
    ),
    Comments(
      userName: 'Chuks Okwuenu',
      userImage: 'https://picsum.photos/300/30',
      message: 'I love to code',
      date: '2021-01-01 12:00:00',
    ),
    Comments(
      userName: 'Chuks Okwuenu',
      userImage: 'https://picsum.photos/300/30',
      message: 'I love to code',
      date: '2021-01-01 12:00:00',
    ),
  ];

  changeTab(val) {
    isall.value = val;
    isPray.value = !val;
    update();
  }
  navigateToOutgoing() {
    Get.to(OutgoingPage());
  }

}
