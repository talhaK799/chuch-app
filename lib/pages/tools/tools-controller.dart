import 'package:churchappenings/api/pastor.dart';
import 'package:churchappenings/models/menu-item.dart';
import 'package:churchappenings/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'birthday-board/birthday-board-page.dart';
import 'guestbook/guestbook-page.dart';
import 'jobs/jobs-page.dart';

class ToolsController extends GetxController {
  final pastorAPI = PastorAPI();

  onInit() async {
    super.onInit();

    // if (await pastorAPI.pastorDesignation()) {
    //   personalTools.add(CMenuItem(
    //     title: 'Pastor Calendar',
    //     icon: FontAwesomeIcons.calendar,
    //     action: () {
    //       navigateTo(Routes.pastorCalendar);
    //     },
    //   ));
    // } else {
    //   personalTools.add(CMenuItem(
    //     title: 'Pastor\'s Appointment',
    //     icon: FontAwesomeIcons.calendar,
    //     action: () {
    //       navigateTo(Routes.pastorSearch);
    //     },
    //   ));
    // }

    update();
  }

  static void onTap() {
    print('Tapped');
  }

  static void navigateTo(String name) {
    Get.toNamed(name);
  }

  
}
