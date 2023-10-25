import 'package:churchappenings/api/department.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/api/stewardship.dart';
import 'package:churchappenings/pages/tools/stewardship/single/single-stewardship-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateStewardshipController extends GetxController {
  final departmentApi = DepartmentAPI();
  final stewardshipApi = StewardshipAPI();
  final ProfileAPI profileApi = ProfileAPI.to;
  RxString paymentMethod = 'Card'.obs;
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

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
    cardNoController.addListener(addSpace);
    expiryDateController.addListener(addSlash);

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
      print(cardNoController.text);
      print(expiryDateController.text);
      print(cvvController.text);
      print(nameController.text);
      // int id = await stewardshipApi.createDonation(donationDetails, total);
      // Get.to(SingleStewardshipPage(), arguments: {"id": id});
    } else {
      Get.snackbar(
        'Donation template should be 100%',
        'Failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  addSlash() {
    String text = expiryDateController.text;
    if (text.length == 2 && !text.contains("/")) {
      expiryDateController.text = "$text/";
      expiryDateController.selection = TextSelection.fromPosition(
        TextPosition(offset: expiryDateController.text.length),
      );
    }
    update();
  }

  addSpace() {
    String text = cardNoController.text;
    if ((text.length - 4) % 5 == 0 &&
        text.length > 0 &&
        text[text.length - 1] != ' ' &&
        text.length <= 20) {
      cardNoController.text = "$text ";
      cardNoController.selection = TextSelection.fromPosition(
        TextPosition(offset: cardNoController.text.length),
      );
    } else if (text.length > 20) {
      // Restrict input beyond the card number format
      cardNoController.text = text.substring(0, 20);
      cardNoController.selection = TextSelection.fromPosition(
        TextPosition(offset: cardNoController.text.length),
      );
    }
    update();
  }
}
