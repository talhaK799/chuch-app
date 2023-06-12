import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/permission.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BulletinsController extends GetxController {
  final ProfileAPI profileApi = ProfileAPI.to;
  final BulletinAPI api = BulletinAPI();
  final PermissionAPI permissionAPI = PermissionAPI();
  var bulletins;
  bool loading = true;
  bool isEditAccess = false;
  Logger log = Logger();

  @override
  void onInit() async {
    await fetchBulletins();
    loading = false;

    // var res = await permissionAPI.getPermissions("FACILITY_BULLETIN");
    // isEditAccess = res["is_modify"];
    update();
    super.onInit();
  }

  Future fetchBulletins() async {
    bulletins = await api.getBulletins(profileApi.selectedChurchId);
    log.d(bulletins);
  }
}
