import 'package:churchappenings/api/pray.dart';
import 'package:churchappenings/constants/red-material-color.dart';

import 'outgoing/outgoing-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrayerController extends GetxController {
  PrayAPI api = PrayAPI();
  bool loading = true;
  dynamic _data = [];
  dynamic get data => _data;
  int offset = 0;

  onInit() async {
    super.onInit();
    await fetchPrayers();
    loading = false;
    update();
  }

  Future fetchPrayers() async {
    _data.addAll(await api.getPrayers(offset));
    offset = offset + 20;
  }

  Future fetchMorePrayers() async {
    loading = true;
    update();
    _data.addAll(await api.getPrayers(offset));
    offset = offset + 20;
    loading = false;
    update();
  }

  // Add Pray should be unique
  Future addPray(int prayerId, String note) async {
    loading = true;
    update();
    print(note);
    await api.addPray(prayerId, note);
  }

  openBottomShit(int id) {
    TextEditingController noteController = TextEditingController();
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 305,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add a note',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 3,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                controller: noteController,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  addPray(id, noteController.text);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: redColor,
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.grey.withOpacity(0.5),
      isDismissible: true,
    );
  }

  navigateToOutgoing() {
    Get.to(OutgoingPage());
  }
}
