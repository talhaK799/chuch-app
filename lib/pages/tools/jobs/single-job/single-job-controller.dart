import 'package:churchappenings/api/jobs.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:get/get.dart';

class SingleJobController extends GetxController {
  int id = -1;
  bool loading = true;
  var data;
  final jobsAPI = JobsAPI();
  final ProfileAPI profileApi = ProfileAPI.to;
  bool myJob = false;

  @override
  void onInit() async {
    super.onInit();
    id = Get.arguments["id"];

    data = await jobsAPI.fetchJobById(id);
    myJob = data["member_id"] == profileApi.memberId ? true : false;
    loading = false;
    update();
  }

  deleteJob() async {
    await jobsAPI.deleteJob(id);
  }
}
