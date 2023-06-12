import 'package:churchappenings/api/poll.dart';
import 'package:get/get.dart';
import 'package:churchappenings/pages/polling/polls-controller.dart';

class VotePollController extends GetxController {
  late int selected = 999;
  late String selectedOption = '';

  markSelected(int id, String option) {
    selected = id;
    selectedOption = option;
    update(['selected']);
  }

  submitPoll(int pollId) async {
    final PollsController controller = Get.find();
    PollAPI pollapi = PollAPI();

    if (selected != 999) {
      await pollapi.addvote(pollId, selectedOption);
    }
    controller.fetchPolls();
    Get.back();
    Get.snackbar(
      'Success',
      'Vote successfully submitted',
      snackPosition: SnackPosition.BOTTOM,
    );
    selected = 999;
  }
}
