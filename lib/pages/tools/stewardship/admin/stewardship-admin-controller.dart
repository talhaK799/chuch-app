import 'package:churchappenings/api/stewardship.dart';
import 'package:churchappenings/pages/tools/stewardship/admin/scan/scan-page.dart';
import 'package:get/get.dart';

class StewardshipAdminController extends GetxController {
  var data = [];
  var data2 = [];
  bool isLoading = false;

  final stewardshipApi = StewardshipAPI();
  bool isAllCollections = false;

  @override
  void onInit() async {
    super.onInit();
    isLoading = true;
    data = await stewardshipApi.getOwnCollectorHistory();
    data2 = await stewardshipApi.getOwnCollectorCurrentPeriodHistory();
    isLoading = false;
    // print(data);
    print(data2);

    update();
  }

  checkInCollection() async {
    isLoading = true;
    update();
    for (int i = 0; i < data2.length; i++) {
      bool isUpdated = await stewardshipApi.endCurrentPeriod(data2[i]["id"]);
      if (isUpdated) {
        print("ended id: ${data2[i]["id"]}");
      } else {
        print("faild id: ${data2[i]["id"]}");
      }
    }
    isLoading = false;
    isAllCollections = true;
    data2 = [];
    update();
    Get.snackbar("Success!", "Collections successfully checkedin");
  }

  scanQrCodeDetails() {
    Get.to(ScanPage());
  }
}
