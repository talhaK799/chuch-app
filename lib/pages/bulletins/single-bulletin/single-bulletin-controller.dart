import 'package:churchappenings/api/bulletin.dart';
import 'package:get/get.dart';

class SingleBulletinController extends GetxController {
  final BulletinAPI api = BulletinAPI();
  late String bulletinId;
  bool loading = true;
  var bulletin;

  @override
  void onInit() async {
    bulletinId = Get.arguments['bulletinId'];
    bulletin = await api.getBulletinById(bulletinId);
    print(bulletin["dept_public_hostings"]);
    loading = false;
    update();
    super.onInit();
  }
}
