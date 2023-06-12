import 'dart:typed_data';

import 'package:churchappenings/constants/api.dart';
import 'package:churchappenings/routes.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

class SearchController extends GetxController {
  final googlePlace = GooglePlace(GooglePlacesAPIKey);
  late Position location;
  List<SearchResult> _churches = [];
  List<Uint8List> _images = [];
  bool _loading = false;
  bool _fetchedImages = false;
  String _oldSearchQuery = '';

  String _activeSearchBy = 'City';
  String get activeSearchBy => _activeSearchBy;

  TextEditingController _cityQuery = TextEditingController();
  TextEditingController _nameQuery = TextEditingController();
  TextEditingController get cityQuery => _cityQuery;
  TextEditingController get nameQuery => _nameQuery;

  List<SearchResult> get churches => _churches;
  List<Uint8List> get images => _images;
  bool get loading => _loading;
  bool get fetchedImages => _fetchedImages;

  handleSubMenuTap(String setactive) async {
    _activeSearchBy = setactive;

    if (setactive == 'Location') {
      await handleChurchesSearch(true);
    }

    update();
  }

  Future fetchChurchesByLocation(double latitude, double longitude) async {
    var result = await googlePlace.search.getNearBySearch(
      Location(
        lat: latitude,
        lng: longitude,
      ),
      5000,
      type: "church",
      keyword: "SDA",
    );
    if (result != null) {
      _churches = result.results!;
    }
  }

  Future fetchChurchesByPlace(String searchQuery) async {
    var result = await googlePlace.search.getTextSearch(
      searchQuery + ' SDA',
      radius: 5000,
      type: "church",
    );
    if (result != null) {
      _churches = result.results!;
    }
  }

  Future fetchChurchByName() async {
    var result = await googlePlace.search.getTextSearch(
      nameQuery.value.text + ' SDA church',
      type: "church",
    );

    if (result != null) {
      _churches = result.results!;
    }
  }

  Future<Uint8List> getPlaceImage(
    String photoRef,
    int width,
    int height,
  ) async {
    Uint8List? result = await googlePlace.photos.get(photoRef, height, width);

    return result ?? Uint8List(0);
  }

  Future fetchImages() async {
    if (_images.length > 0) _images.removeRange(0, _images.length);

    for (int i = 0; i < _churches.length; i++) {
      if (_churches[i].photos != null) {
        final imageWidth = _churches[i].photos!.first.width;
        final imageHeight = _churches[i].photos!.first.height;
        _images.add(
          await getPlaceImage(
            _churches[i].photos!.first.photoReference!,
            imageWidth!,
            imageHeight!,
          ),
        );
      } else {
        _images.add(Uint8List(0));
      }
    }
  }

  Future<void> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    try {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Future.error('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
        return;
      }

      location = await Geolocator.getCurrentPosition();
    } catch (e) {
      print(e);
    }
  }

  Future<void> handleChurchesSearch(bool bylocation) async {
    _loading = true;
    update();
    if (bylocation) {
      await getCurrentPosition();
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _loading = false;
        update();
        return;
      }
      await fetchChurchesByLocation(location.latitude, location.longitude);
    } else {
      if (activeSearchBy == 'City') {
        if (_cityQuery.value.text != _oldSearchQuery) {
          await fetchChurchesByPlace(_cityQuery.value.text);
          _oldSearchQuery = _cityQuery.value.text;
        }
      } else {
        await fetchChurchByName();
      }
    }

    _loading = false;
    _fetchedImages = false;
    update();

    await fetchImages();

    if (_churches.length != _images.length) {
      handleChurchesSearch(bylocation);
    } else {
      _fetchedImages = true;
      update();
    }
  }

  navigateToFav() {
    Get.toNamed(Routes.favChurches);
  }
}
