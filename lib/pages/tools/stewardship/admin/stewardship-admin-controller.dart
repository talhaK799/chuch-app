import 'package:churchappenings/api/stewardship.dart';
import 'package:churchappenings/pages/tools/stewardship/admin/scan/scan-page.dart';
import 'package:get/get.dart';

class StewardshipAdminController extends GetxController {
  var data = [];
  final stewardshipApi = StewardshipAPI();
  bool isAllCollections = false;

  @override
  void onInit() async {
    super.onInit();

    data = await stewardshipApi.getDonationHistory();
    print(data);
    update();
  }

  scanQrCodeDetails() {
    Get.to(ScanPage());
  }
}
