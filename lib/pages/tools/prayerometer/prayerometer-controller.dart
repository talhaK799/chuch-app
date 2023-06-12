import 'package:churchappenings/api/pray.dart';
import 'package:get/get.dart';

class PrayerometerController extends GetxController {
  PrayAPI api = PrayAPI();
  double score = 0.0;

  @override
  void onInit() async {
    super.onInit();
    score = await api.getPrayrometerData();
    update();
  }
}
