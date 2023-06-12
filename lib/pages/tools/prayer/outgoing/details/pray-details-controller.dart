import 'package:churchappenings/api/pray.dart';
import 'package:get/get.dart';

class PrayDetailsController extends GetxController {
  late int id;
  bool _loading = true;
  var data;
  bool get loading => _loading;

  @override
  void onInit() async {
    id = Get.arguments['id'];
    await getdata();

    _loading = false;
    update();
    super.onInit();
  }

  Future getdata() async {
    PrayAPI api = PrayAPI();
    data = await api.getDetailsOfPrays(id);
    print(data);
  }
}
