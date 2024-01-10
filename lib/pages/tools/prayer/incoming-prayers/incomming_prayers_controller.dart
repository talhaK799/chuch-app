import 'package:churchappenings/api/pray.dart';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:comment_box/comment/comment.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../outgoing/outgoing-page.dart';

class IcncommingPrayerController extends GetxController {
  PrayAPI api = PrayAPI();
  bool loading = true;
  bool anonymous = false;
  dynamic _data = [];
  var comments;
  dynamic get data => _data;
  // dynamic get comments => _comments;
  int offset = 0;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  onInit() async {
    super.onInit();
    await fetchPrayers();
    loading = false;
    update();
  }

  Future fetchPrayers() async {
    _data.addAll(await api.getPrayers(offset));
    // await getPryerComments(
    //   _data[0]['id'],
    // );
    offset = offset + 20;
  }

  getPryerComments(id) async {
    print('prayer id ==> $id');
    comments = await api.getDetailsOfPrays(id);
  }

  handleOnChnageAnonymus(bool? value) {
    anonymous = value ?? false;
    update();
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

  openBottomShit(int id, context) async {
    await getPryerComments(id);
    update();
    // TextEditingController noteController = TextEditingController();
  }

  updt() {
    update();
  }
}
