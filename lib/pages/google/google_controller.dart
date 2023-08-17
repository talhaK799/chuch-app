// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleController extends GetxController {
//   Set<Marker> markers = Set<Marker>();

//   addMarker() {
//     markers.add(
//       Marker(
//         // icon: BitmapDescriptor.fromBytes(photographerIcon),
//         position: LatLng(36.778259, -119.417931),
//         markerId: MarkerId('subject'),
//         infoWindow: InfoWindow(title: 'selected_location'.tr),
//       ),
//     );
//     update();
//   }

//   changeMarker(LatLng latLng) async {
//     shop.latitude = latLng.latitude;
//     shop.longnitude = latLng.longitude;
//     markers = Set<Marker>();
//     markers.add(Marker(
//       // icon: BitmapDescriptor.fromBytes(photographerIcon),
//       position: latLng,
//       markerId: MarkerId('subject'),
//       infoWindow: InfoWindow(title: 'selected_location'.tr),
//     ));
//     shop.location = await locationService.getAddressFromLatLng(
//         Loc.Location(lat: latLng.latitude, lng: latLng.longitude));

//     update();
//   }
//   // changeMarker(LatLng latLng) async {
//   //   shop.latitude = latLng.latitude;
//   //   shop.longnitude = latLng.longitude;
//   //   markers = Set<Marker>();
//   //   markers.add(Marker(
//   //     // icon: BitmapDescriptor.fromBytes(photographerIcon),
//   //     position: latLng,
//   //     markerId: MarkerId('subject'),
//   //     infoWindow: InfoWindow(title: 'selected_location'.tr),
//   //   ));
//   //   shop.location = await locationService.getAddressFromLatLng(
//   //       Loc.Location(lat: latLng.latitude, lng: latLng.longitude));

//   //   notifyListeners();
//   //   setState(ViewState.idle);
//   // }
// }
