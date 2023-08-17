// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? _mapController;
//   late Position _currentPosition;
//   Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     setState(() {
//       _currentPosition = position;
//       _markers.add(
//         Marker(
//           markerId: MarkerId("current_location"),
//           position:
//               LatLng(_currentPosition.latitude, _currentPosition.longitude),
//         ),
//       );
//     });

//     _mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
//           zoom: 15,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Current Location'),
//       ),
//       body: GoogleMap(
//         onMapCreated: (controller) {
//           setState(() {
//             _mapController = controller;
//           });
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(0, 0), // Default initial position
//           zoom: 12,
//         ),
//         markers: _markers,
//       ),
//     );
//   }
// }


// // import 'package:churchappenings/pages/google/google_controller.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // class GoogleMapScreen extends StatelessWidget {
// //   const GoogleMapScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<GoogleController>(
// //       init: GoogleController(),
// //       builder: (model) => Scaffold(
// //         body: Stack(
// //           alignment: Alignment.bottomCenter,
// //           fit: StackFit.loose,
// //           children: [
// //             GoogleMap(
// //               markers: model.markers,
// //               onTap: (LatLng markerLocation) {
// //                 print('onTap');
// //                 model.changeMarker(markerLocation);
// //                 model.isLocationButtonShow = true;
// //               },
// //               mapType: MapType.normal,
// //               initialCameraPosition: model.kGooglePlex,
// //               onMapCreated: (GoogleMapController mapController) {
// //                 model.controller.complete(mapController);
// //               },
// //             ),
// //             model.isLocationButtonShow == true
// //                 ? GestureDetector(
// //                     onTap: () {
// //                       Get.back(result: model.shop.location);
// //                       model.isLocationButtonShow = false;
// //                     },
// //                     child: Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 70),
// //                       child: Container(
// //                         height: 50,
// //                         decoration: BoxDecoration(
// //                             // color: primaryColor,
// //                             borderRadius: BorderRadius.circular(7)),
// //                         child: Center(
// //                             child: Text(
// //                           "Save Location",
// //                         )),
// //                       ),
// //                     ),
// //                   )
// //                 : Container(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
