import 'package:churchappenings/api/personal-event.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SingleMyEventController extends GetxController {
  late String happeningId;
  var details;
  late bool loading;
  late String date;
  late String time;
  bool pastEvent = true;

  TextEditingController _inviteEmail = TextEditingController();
  TextEditingController get inviteEmail => _inviteEmail;

  @override
  void onInit() async {
    loading = true;
    update();
    happeningId = Get.arguments['happeningId'];
    await getdata();
    DateTime eventTime = DateTime.parse(details['date_time']);
    var todayNow = DateTime.now();

    List<String> dateTime = formatDateTime(eventTime);

    date = dateTime[0];
    time = dateTime[1];

    if (eventTime.isAfter(todayNow)) pastEvent = false;

    loading = false;
    update();
    super.onInit();
  }

  Future invite() async {
    print(inviteEmail.text);
    if (inviteEmail.text.isEmail) {
      PersonalEventAPI api = PersonalEventAPI();
      await api.inviteMemberUsingEmail(inviteEmail.text, details['id']);
      await getdata();
      Get.snackbar(
        'Success',
        inviteEmail.text + ' has been invited.',
        snackPosition: SnackPosition.BOTTOM,
      );
      update();
    }
  }

  Future getdata() async {
    PersonalEventAPI api = PersonalEventAPI();
    var res = await api.getPersonalEvent(happeningId);
    details = res['data']['happening'][0];

    print(details);
  }
}
