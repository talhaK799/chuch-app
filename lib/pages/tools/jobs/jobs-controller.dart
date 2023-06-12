import 'package:churchappenings/api/jobs.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {
  var jobs = [];
  bool loading = true;
  final jobsAPI = JobsAPI();

  @override
  void onInit() async {
    super.onInit();

    jobs = await jobsAPI.fetchJobs();

    loading = false;
    update();
  }
}
