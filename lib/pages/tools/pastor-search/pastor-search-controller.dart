import 'package:churchappenings/api/pastor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastorSearchController extends GetxController {
  final pastorAPI = PastorAPI();
  bool loading = false;

  TextEditingController _queryController = TextEditingController();
  TextEditingController get queryController => _queryController;

  dynamic pastors = [];

  Future handleSubmit() async {
    loading = true;
    update();
    pastors = await pastorAPI.searchPastors(queryController.text);
    print(pastors);
    loading = false;
    update();
  }
}
