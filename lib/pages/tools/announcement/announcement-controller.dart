import 'package:churchappenings/api/announcement.dart';
import 'add/add-announcement-page.dart';
import 'package:get/get.dart';

class AnnouncementController extends GetxController {
  AnnouncementAPI api = AnnouncementAPI();
  var announcements;
  bool loading = true;

  @override
  void onReady() async {
    announcements = await api.getAnnouncemnts();
    print(announcements);
    loading = false;
    update();
    super.onReady();
  }

  navigateToAddAnnouncement() {
    Get.to(AddAnnouncementPage());
  }

  Future deleteAnnouncement(int id) async {
    await api.deleteAnnouncement(id);
    announcements = await api.getAnnouncemnts();
    update();
  }
}
