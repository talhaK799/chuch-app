import 'package:churchappenings/api/department.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/api/stewardship.dart';
import 'package:churchappenings/pages/tools/stewardship/single/single-stewardship-page.dart';
import 'package:get/get.dart';

class CreateStewardshipController extends GetxController {
  final departmentApi = DepartmentAPI();
  final stewardshipApi = StewardshipAPI();
  final ProfileAPI profileApi = ProfileAPI.to;

  var donationDetails = [];
  var total = 0;
  bool loading = true;

  @override
  void onInit() async {
    super.onInit();
    donationDetails = await stewardshipApi
        .getDonationPrefrenceForCHurchId(profileApi.selectedChurchId);
    totalCalculator();
    loading = false;
    update();
  }

  onChangeField(int key, String value) {
    donationDetails[key]["value"] = int.tryParse(value) ?? 0;
    print(donationDetails);
    totalCalculator();
    update();
  }

  totalCalculator() {
    total = 0;
    for (int i = 0; i < donationDetails.length; i++) {
      total = (donationDetails[i]["value"] == null
              ? 0
              : donationDetails[i]["value"]) +
          total;
    }
    update();
  }

  onSubmit() async {
    if (total > 0) {
      int id = await stewardshipApi.createDonation(donationDetails, total);
      Get.to(SingleStewardshipPage(), arguments: {"id": id});
    } else {
      Get.snackbar(
        'Donation template should be 100%',
        'Failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
