import 'package:get/get.dart';

class RequestChurchController extends GetxController {
  bool loading = false;
  // LiveStreamAPI liveStreamAPI = LiveStreamAPI();
  // var response;
  // List<String> links = [];

  // @override
  // onInit() async {
  //   super.onInit();
  //   await getlinks();
  //   loading = false;
  //   update();
  // }

  // getlinks() async {
  //   response = await liveStreamAPI.getLink();
  //   // response = await departmentApi.getAllDepartments();
  //   print("**** facility Response ==== >>> $response");
  //   for (int i = 0; i < response['facility_settings'].length; i++) {
  //     links.add(response['facility_settings'][i]['setting_value']);
  //   }
  //   loading = false;
  //   update();
  // }

  // visitUrl(index) async {
  //   final uri = Uri.parse(
  //     links[index],
  //   );
  //   print('url ===> $uri');
  //   bool launched = await launchUrl(uri.toString());
  //   if (!launched) {
  //     throw Exception('Could not launch $uri');
  //   }
  // }
}
