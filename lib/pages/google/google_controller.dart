import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' as Loc;

class GoogleController extends GetxController {
  double latitude = 0.0;
  double longitude = 0.0;
  Set<Marker> markers = Set<Marker>();
  Completer<GoogleMapController> controller = Completer();
  String? location;
  LatLng? latLng;

  addMarker() {
    markers.add(
      Marker(
        // icon: BitmapDescriptor.fromBytes(photographerIcon),
        position: LatLng(36.778259, -119.417931),
        markerId: MarkerId('subject'),
        infoWindow: InfoWindow(title: 'selected_location'.tr),
      ),
    );
    update();
  }

  changeMarker(LatLng latLng) async {
    latitude = latLng.latitude;
    longitude = latLng.longitude;
    markers = Set<Marker>();

    markers.add(Marker(
      position: latLng,
      markerId: MarkerId('subject'),
      infoWindow: InfoWindow(title: 'Selected Location'),
    ));
    location = await getAddressFromLatLng(
        Loc.Location(lat: latLng.latitude, lng: latLng.longitude));

    update();
  }

  Future<String> getAddressFromLatLng(Loc.Location location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.lat!, location.lng!);

      Placemark place = placemarks[0];
      print("the location is  ${place.thoroughfare} " +
          " ${place.subLocality}" +
          " ${place.locality}" +
          " ${place.country}");
      return "${place.thoroughfare} ${place.subLocality} ${place.locality} ${place.country}";
    } catch (e) {
      print("the exception is $e");
      return '';
    }
  }
}
