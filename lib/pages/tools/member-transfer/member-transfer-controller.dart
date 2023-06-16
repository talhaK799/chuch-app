import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:churchappenings/api/members.dart';
import '../../../api/search_facilities.dart';
import '../../../models/facility.dart';
import '../../../services/hasura.dart';

class MemberTransferController extends GetxController {
  final HasuraService hasura = HasuraService.to;
  SearchFacilities serachFacilities = SearchFacilities();
  String? selectedCountry;
  List<String> countries = [
    'Andorra',
    'Austria',
    'United States / American',
    'Canada',
    'China',
    'Japan',
    'Angola',
    'Ascension Island',
  ];

  TextEditingController nameController = TextEditingController();

  MembersAPI api = MembersAPI();
  var churches = [];
  List<Facility> facilities = [];

  getFacilities() async {
    await serachFacilities.fetchFacilities(selectedCountry.toString());

    update();
  }

  onSubmit() async {
    if (nameController.text.length < 3) {
      Get.snackbar('Validation error', 'Enter 3 characters minimum',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      churches = await api.getAllChurches(nameController.text);
      update();
    }
  }

  memberInvite(int id) async {
    await api.memberTransfer(id);
  }
}
