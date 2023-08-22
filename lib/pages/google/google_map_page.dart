import 'package:churchappenings/pages/google/google_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocation extends StatefulWidget {
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  // GoogleMapController? _mapController;
  // late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    // _getCurrentLocation();
  }

  // void _getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  // setState(() {
  //   // _currentPosition = position;
  //   // markers.add(
  //   //   Marker(
  //   //     markerId: MarkerId("current_location"),
  //   //     position:
  //   //         LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //   //   ),
  //   // );
  // });

  //   _mapController?.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //         zoom: 15,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GoogleController>(
      init: GoogleController(),
      builder: (model) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(result: model.location);
            },
          ),
          title: Text('Select Location'),
        ),
        body: GoogleMap(
          onMapCreated: (GoogleMapController mapController) {
            model.controller.complete(mapController);
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(37.42796133580664, -122.085749655962),
            zoom: 12,
          ),
          myLocationEnabled: true,
          onTap: (LatLng markerLocation) {
            model.changeMarker(markerLocation);
          },
          markers: model.markers,
        ),
      ),
    );
  }
}


// import 'package:churchappenings/pages/google/google_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleSelectLocation extends StatelessWidget {
//   const GoogleMapScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<GoogleController>(
//       init: GoogleController(),
//       builder: (model) => Scaffold(
//         body: Stack(
//           alignment: Alignment.bottomCenter,
//           fit: StackFit.loose,
//           children: [
//             GoogleMap(
//               markers: model.markers,
//               onTap: (LatLng markerLocation) {
//                 print('onTap');
//                 model.changeMarker(markerLocation);
//                 model.isLocationButtonShow = true;
//               },
//               mapType: MapType.normal,
//               initialCameraPosition: model.kGooglePlex,
//               onMapCreated: (GoogleMapController mapController) {
//                 model.controller.complete(mapController);
//               },
//             ),
//             model.isLocationButtonShow == true
//                 ? GestureDetector(
//                     onTap: () {
//                       Get.back(result: model.shop.location);
//                       model.isLocationButtonShow = false;
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 70),
//                       child: Container(
//                         height: 50,
//                         decoration: BoxDecoration(
//                             // color: primaryColor,
//                             borderRadius: BorderRadius.circular(7)),
//                         child: Center(
//                             child: Text(
//                           "Save Location",
//                         )),
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
