import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/api/stewardship.dart';
import 'package:get/get.dart';

import '../../../../../constants/strings.dart';
import '../../single/single-stewardship-page.dart';

class SingleAdminStewardshipController extends GetxController {
  var data;
  bool loading = true;
  int id = 0;
  bool enabled = true;

  final stewardshipApi = StewardshipAPI();
  final ProfileAPI profileAPI = new ProfileAPI();

  onInit() async {
    super.onInit();
    id = Get.arguments["id"];
    print("id ::===:: $id");
    data = await stewardshipApi.getOwnDonationHistoryById(id);
    await submitCollectorDetails();
    loading = false;
    update();
  }

  submitCollectorDetails() async {
    String actAs = collector;
    String paymentType = "cash";
    var donationDetails = data["donation_details"];
    var total = data["donation_amount"];
    var periodId =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
    id = await stewardshipApi.createDonation(
        donationDetails, total, actAs, paymentType, periodId);
    // Get.to(SingleStewardshipPage(), arguments: {"id": -1});
  }

  onVerify() async {
    await stewardshipApi.verifyById(id);
    data = await stewardshipApi.getOwnDonationHistoryById(id);
    update();
  }
}
