import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/poll.dart';
import 'package:get/get.dart';
import 'package:churchappenings/api/poll.dart';

class PollsController extends GetxController {
  List<PollModel> polls = [];
  List<PollModel> everyOnePolls = [];
  PollAPI pollapi = PollAPI();
  bool isElligibleForCreatePoll = false;
  bool isLoading = false;
  final ProfileAPI profileApi = ProfileAPI.to;
  PollsController() {
    isModify(profileApi.memberId.toString());
    fetchEveryOnePolls();
    // fetchPolls();
  }

  onInit() async {
    await fetchPolls();
    super.onInit();
  }

  fetchPolls() async {
    isLoading = true;
    polls = await pollapi.fetchPolls() ?? [];
    update(['polls']);
    isLoading = false;
    update();
  }

  bool hasLink(String inputString) {
    RegExp urlPattern = RegExp(r'https?://\S+|www\.\S+');
    return urlPattern.hasMatch(inputString);
  }

  Future<void> isModify(String memberId) async {
    var res = await pollapi.checkPermissionForCreatePoll(memberId);
    List<dynamic> data = res["data"]["member_facility_permission"];
    data.forEach((element) {
      if (element["is_modify"] == true) {
        isElligibleForCreatePoll = true;
      }
    });
    update();
  }

  Future<void> fetchEveryOnePolls() async {
    isLoading = true;
    everyOnePolls = await pollapi.fatchPollEveryOne() ?? [];
    // update(['polls']);
    isLoading = false;
    update();
  }
}
