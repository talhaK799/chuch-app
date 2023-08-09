import 'package:churchappenings/api/poll.dart';
import 'package:churchappenings/models/poll.dart';
import 'package:get/get.dart';
import 'package:churchappenings/pages/polling/polls-controller.dart';

class VotePollController extends GetxController {
  late int selected = 999;
  late String selectedOption = '';
  String? imagePath;
  String? uploadedImageUrl;
  PollModel poll = PollModel();

  VotePollController({PollModel? pol}) {
    this.poll = pol ?? PollModel();
    // fetchPolls();
  }

  markSelected(int id, String option) {
    selected = id;
    selectedOption = option;
    update(['selected']);
  }

  bool hasLink(String inputString) {
    RegExp urlPattern = RegExp(r'https?://\S+|www\.\S+');
    return urlPattern.hasMatch(inputString);
  }

  submitPoll(int pollId) async {
    final PollsController controller = Get.find();
    PollAPI pollapi = PollAPI();
    // if (imagePath != null) {
    // uploadedImageUrl = await uploadImage(imagePath!);
    // }
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
    // imagePath = null;
    // update();
  }
}
