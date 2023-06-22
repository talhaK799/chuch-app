import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:churchappenings/api/members.dart';
import '../../../api/search-church.dart';
import '../../../models/church.dart';
import '../../../services/hasura.dart';

class MemberTransferController extends GetxController {
  final HasuraService hasura = HasuraService.to;

  SearchChurchAPI searchChurchApi = SearchChurchAPI();
  String? selectedCountry;
  String? search;
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

  bool serached = false;

  TextEditingController nameController = TextEditingController();

  MembersAPI api = MembersAPI();
  var churches = [];
  List<ChurchModel> churchList = [];
  List<ChurchModel> serachList = [];

  getFacilities() async {
    churchList = [];
    var res =
        await searchChurchApi.fetchChurchByCountry(selectedCountry.toString());
    res.forEach((value) {
      churchList.add(ChurchModel.fromSearchChurchJson(value));
    });

    print("Churches length => ${churchList.length}");

    update();
  }

  filteredChurchList(String search) {
    if (search.isEmpty) {
      serachList = [];
      serached = false;
    } else {
      serachList = [];
      serachList = churchList
          .where((church) =>
              church.name.toLowerCase().contains(search.toLowerCase()))
          .toList();
      serached = true;
      log("SEARCH:: $serached");
    }
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
