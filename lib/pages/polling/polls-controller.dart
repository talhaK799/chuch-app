import 'package:churchappenings/models/poll.dart';
import 'package:get/get.dart';
import 'package:churchappenings/api/poll.dart';

class PollsController extends GetxController {
  List<PollModel> polls = [];
  PollAPI pollapi = PollAPI();

  onInit() async {
    await fetchPolls();
    super.onInit();
  }

  fetchPolls() async {
    polls = await pollapi.fetchPolls() ?? [];
    update(['polls']);
  }
}
