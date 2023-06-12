import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/api/stewardship.dart';
import 'package:get/get.dart';

class SingleAdminStewardshipController extends GetxController {
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

  onVerify() async {
    await stewardshipApi.verifyById(id);
    data = await stewardshipApi.getOwnDonationHistoryById(id);
    update();
  }
}
