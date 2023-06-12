import 'package:churchappenings/api/members.dart';
import 'package:get/get.dart';

class MembersController extends GetxController {
  MembersAPI membersAPI = new MembersAPI();
  var members = [];

  bool loading = true;

  onInit() async {
    super.onInit();

    members = await membersAPI.getMembers();
    loading = false;
    update();
  }
}
