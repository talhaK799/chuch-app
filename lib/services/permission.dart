// import 'package:geolocator/geolocator.dart';

import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Location location = new Location();
  bool isMapEnable = false;

  PermissionService() {
    checkMapPermisson();
    enalbleGoogleMap();
  }

  enalbleGoogleMap() async {
    if (await Permission.location.serviceStatus.isDisabled) {
      print("Location is disabled ==> Please enable location");
      isMapEnable = await location.requestService();
      print("Location status ==> $isMapEnable");
      return isMapEnable;
    } else if (await Permission.location.serviceStatus.isEnabled) {
      print("Location is enable");
      return true;
    } else if (await Permission.location.isPermanentlyDenied) {
      print("Location is enable");
      return false;
    }
  }

  checkMapPermisson() async {
    // LocationPermission permission = await checkMapPermisson();
    // if (permission == LocationPermission.denied ||
    //     permission == LocationPermission.deniedForever) {
    //   await Permission.location.request();
    // }
    if (await Permission.location.status.isDenied) {
      await Permission.location.request();
      // PermissionStatus status =
    }
    if (await Permission.speech.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
