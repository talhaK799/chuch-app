import 'package:churchappenings/api/calendar.dart';
import 'package:get/get.dart';

class CalendarControllerX extends GetxController {
  String activeCalendarBy = 'Upcoming';

  dynamic upcomingEvents;
  dynamic pastEvents;

  bool loading = true;
  int pastEventOffset = 0;

  bool allPastEventsFetched = false;

  CalendarAPI api = CalendarAPI();

  onInit() async {
    super.onInit();

    if (activeCalendarBy == 'Upcoming') {
      upcomingEvents = await api.getUpcomingPersonalCalendar();
    }

    loading = false;
    update();
  }

  handleSubMenuTap(String setactive) async {
    loading = true;
    update();
    activeCalendarBy = setactive;

    if (activeCalendarBy == 'Upcoming' && upcomingEvents == null) {
      upcomingEvents = await api.getUpcomingPersonalCalendar();
    }

    if (activeCalendarBy == 'Past' && pastEvents == null) {
      pastEvents = await api.getPastPersonalCalendar(pastEventOffset);
      pastEventOffset += 10;
      if (pastEvents.length < 10) {
        allPastEventsFetched = true;
      }
    }
    loading = false;
    update();
  }

  handleLoadMorePast() async {
    if (!allPastEventsFetched) {
      var temp = await api.getPastPersonalCalendar(pastEventOffset);
      pastEvents.addAll(await api.getPastPersonalCalendar(pastEventOffset));
      pastEventOffset += 10;
      if (temp.length < 10) {
        allPastEventsFetched = true;
      }
    }
    update();
  }
}
