import 'dart:developer';

import 'package:churchappenings/api/guest_chat_api.dart';
import 'package:churchappenings/models/add_guestbook.dart';
import 'package:churchappenings/models/get_church_facility%20model.dart';
import 'package:churchappenings/pages/tools/guestbook/addguest.dart';
import 'package:churchappenings/utils/date-picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddGuestController extends GetxController {
  DateTime? selectedDate;
  //RxList<Facility> chatMessages = <Facility>[].obs;
  List facilitymodel = [];
  TextEditingController dateController = TextEditingController();

  Future openDatePicker(BuildContext context) async {
    selectedDate = (await datePicker(context, selectedDate))!;

    dateController.text = DateFormat.yMMMd().format(selectedDate!).toString();
    update();
  }

  List<dynamic> facilities = [];
  String? selectedFacilityId;

  onInit() async {
    getChurchAffiliation();
    // final facilityId = int.parse(selectedFacilityId?? "");
    // addguestm.requestedFacilityId = facilityId;
    update();
  }

  GuestBookInputModel addguestm = GuestBookInputModel();
  addGuests() {
    addguestm.requestCall = false;
    addguestm.dateOfVisit = dateController.text.toString();
    log('date of visit ${addguestm.dateOfVisit}');
    GuestChatApi().addGuestApi(addguestm);
    update();
  }

  getChurchAffiliation() async {
    List<dynamic> response = await GuestChatApi().getChurchAffiliation();

    facilities = response;
    log('message $facilities');

    update();
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return text.substring(0, maxLength) + '...';
    }
  }
}
