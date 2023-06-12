import 'package:churchappenings/api/photo-gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoGalleryController extends GetxController {
  bool loading = true;
  var photos = [];
  TextEditingController searchQueryController = TextEditingController();

  PhotoGalleryAPI photoGalleryAPI = PhotoGalleryAPI();

  onInit() async {
    super.onInit();
    await fetchPhotos();
    loading = false;
    update();
  }

  Future fetchPhotos() async {
    photos = await photoGalleryAPI.getPhotos(searchQueryController.text);
  }
}
