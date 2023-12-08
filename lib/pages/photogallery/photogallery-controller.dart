import 'package:churchappenings/api/photo-gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/photo.dart';

class PhotoGalleryController extends GetxController {
  bool loading = true;
  List<Photos> photos = [];
  List<Photos> searchedPhotos = [];
  bool isSearching = false;

  Map<String, dynamic> response = {};
  TextEditingController searchQueryController = TextEditingController();

  PhotoGalleryAPI photoGalleryAPI = PhotoGalleryAPI();

  onInit() async {
    super.onInit();
    await fetchPhotos();
    loading = false;
    update();
  }

  searchImages(String title) {
    if (title.isEmpty|| title==null) {
      isSearching = false;
      update();
    } else {
      isSearching = true;
      searchedPhotos = photos
          .where((image) =>
              image.title!.toLowerCase().contains(title.toLowerCase()))
          .toList();
      update();
    }
  }

  fetchPhotos() async {
    response = await photoGalleryAPI.getPhotos();
    print(
        "**** Response ==== >>> ${response['photo_gallery'][2]['image_uri']}");
    for (int i = 0; i < response["photo_gallery"].length; i++) {
      photos.add(Photos.fromJson(response["photo_gallery"][i]));
    }
    print('photoes length===>${response.length} ${photos.length}');
    loading = false;
    update();
  }
}
