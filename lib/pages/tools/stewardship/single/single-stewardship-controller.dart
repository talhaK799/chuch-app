import 'dart:async';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/api/stewardship.dart';
import 'package:churchappenings/utils/launch-url.dart';
import 'package:get/get.dart';

class SingleStewardshipController extends GetxController {
  var data;
  bool loading = true;
  int id = -1;
  bool enabled = true;

  final stewardshipApi = StewardshipAPI();
  final ProfileAPI profileAPI = new ProfileAPI();

  onInit() async {
    super.onInit();

    id = Get.arguments["id"];
    data = await stewardshipApi.getOwnDonationHistoryById(id);

    loading = false;
    update();
  }

  onDeletePressed() async {
    await stewardshipApi.deleteById(id);
  }

  onPayOnline() async {
    if (enabled) {
      enabled = false;
      var res = await stewardshipApi.payOnline(
        data["facility_id"],
        data["donation_amount"],
        id,
      );

      print(res);
      Timer(Duration(seconds: 1), () {
        enabled = true;
      });

      if (res["status"]) {
        launchUrl(res["url"]);
      } else {
        Get.snackbar(
          'Error',
          'Something went wrong. Contact your church administrator',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
