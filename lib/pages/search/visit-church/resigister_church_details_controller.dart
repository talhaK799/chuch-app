import 'dart:developer';

import 'package:churchappenings/api/members.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegisterChurchDetailsController extends GetxController {
  bool loading = true;
  MembersAPI membersAPI = MembersAPI();
  final localData = LocalData();

  onInit() async {
    churchId = await localData.getInt('Churchid');
    log('idd $churchId');
    await getMemberStatus();
    log('$memberStatus');
    loading = false;
    update();
  }

  int churchId = 0;
  bool? memberTransferr = false;
  memberTransfer(id) async {
    memberTransferr = await membersAPI.memberTransfer(id);
    log('nnnnnnnnnnnnnnnnnnn$memberTransferr');
    update();
  }

  List<dynamic> memberStatus = [];

  getMemberStatus() async {
    memberStatus = await membersAPI.getMemberStatus(churchId);
    log('kkkkkkkkkkkkkkk${memberStatus}');
    update();
  }
}
