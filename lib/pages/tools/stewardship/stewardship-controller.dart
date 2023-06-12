import 'package:churchappenings/api/stewardship.dart';
import 'package:get/get.dart';

class StewardshipController extends GetxController {
  var data = [];
  final stewardshipApi = StewardshipAPI();

  @override
  void onInit() async {
    super.onInit();

    data = await stewardshipApi.getOwnDonationHistory();
    print(data);
    update();
  }
}
