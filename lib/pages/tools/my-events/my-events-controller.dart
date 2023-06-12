import 'package:churchappenings/api/personal-event.dart';
import 'package:churchappenings/pages/tools/my-events/create/create-my-event-page.dart';
import 'package:get/get.dart';

class MyEventsController extends GetxController {
  PersonalEventAPI api = PersonalEventAPI();
  String activeEventBy = 'Upcoming';
  var events;
  bool loading = true;
  var pastEvents;
  bool allPastEventsFetched = false;
  int pastOffset = 0;

  onInit() async {
    super.onInit();
    events = await api.getAllPersonalEvent();
    print(events);
    loading = false;
    update();
  }

  handleSubMenuTap(String setactive) async {
    loading = true;
    update();
    activeEventBy = setactive;

    if (activeEventBy == 'Upcoming' && events == null) {
      events = await api.getAllPersonalEvent();
    }

    if (activeEventBy == 'Past' && pastEvents == null) {
      pastEvents = await api.getPastPersonalEvents(pastOffset);
      pastOffset += 10;
      if (pastEvents.length < 10) allPastEventsFetched = true;
    }

    loading = false;
    update();
  }

  handleLoadMorePast() async {
    pastEvents = await api.getPastPersonalEvents(pastOffset);
    pastOffset += 10;
    if (pastEvents.length < 10) allPastEventsFetched = true;
    update();
  }

  navigateToCreate() {
    Get.to(CreateMyEventPage());
  }
}
