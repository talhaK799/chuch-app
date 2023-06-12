import 'package:churchappenings/api/search-church.dart';
import 'package:churchappenings/pages/search/search-details/search-details-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribedChurchesController extends GetxController {
  TextEditingController _searchQuery = TextEditingController();
  TextEditingController get searchQuery => _searchQuery;

  SearchChurchAPI api = SearchChurchAPI();

  var data = [];
  bool loading = false;

  handleFetch() async {
    loading = true;
    update();

    data = await api.fetchChurchByName(searchQuery.text);
    loading = false;
    update();
  }

  navigateToDetails(String id) {
    Get.to(SearchDetailsPage(), arguments: {"id": id});
  }
}
