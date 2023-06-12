import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:get/get.dart';

class BulletinCreatedByMeController extends GetxController {
  final ProfileAPI profileApi = ProfileAPI.to;
  final BulletinAPI api = BulletinAPI();
  var bulletins;
  bool loading = true;

  @override
  void onInit() async {
    await fetchBulletins();
    loading = false;
    update();
    super.onInit();
  }

  Future fetchBulletins() async {
    bulletins = await api.getDraftBulletins(profileApi.selectedChurchId);
    print(bulletins);
  }
}
