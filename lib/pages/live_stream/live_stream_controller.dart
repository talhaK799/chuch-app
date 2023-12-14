import 'package:churchappenings/utils/launch-url.dart';
import 'package:get/get.dart';

import '../../api/live_stream.dart';

class LiveStreamController extends GetxController {
  bool loading = true;
  LiveStreamAPI liveStreamAPI = LiveStreamAPI();
  var response;
  List<String> links = [];

  @override
  onInit() async {
    super.onInit();
    await getlinks();
    loading = false;
    update();
  }

  getlinks() async {
    response = await liveStreamAPI.getLink();
    // response = await departmentApi.getAllDepartments();
    print("**** facility Response ==== >>> $response");
    for (int i = 0; i < response['facility_settings'].length; i++) {
      links.add(response['facility_settings'][i]['setting_value']);
    }
    loading = false;
    update();
  }

  visitUrl(index) async {
    final uri = Uri.parse(
      links[index],
    );
    print('url ===> $uri');
    bool launched = await launchUrl(uri.toString());
    if (!launched) {
      throw Exception('Could not launch $uri');
    }
  }
}
