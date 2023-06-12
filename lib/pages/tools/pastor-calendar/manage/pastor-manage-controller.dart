import 'package:churchappenings/api/pastor.dart';
import 'package:get/get.dart';

class PastorManageController extends GetxController {
  PastorAPI pastorAPI = PastorAPI();

  dynamic daysAvailibility = {
    "Sunday": true,
    "Monday": true,
    "Tuesday": true,
    "Wednesday": true,
    "Thursday": true,
    "Friday": true,
    "Saturday": true,
  };

  bool publicVisibility = true;
  bool loading = true;

  @override
  void onInit() async {
    super.onInit();

    var data = await pastorAPI.getPastorCalendarSettings();
    daysAvailibility = data["availibility"];
    publicVisibility = data["visibility"];

    loading = false;
    update();
  }

  handleDaysAvailibilityUpdate(key, value) {
    daysAvailibility[key] = value;
    update();
  }

  handlePublicVisibilityUpdate(value) {
    publicVisibility = value;
    update();
  }

  handleSave() async {
    await pastorAPI.updatePastorCalendarSettings(
      publicVisibility,
      daysAvailibility,
    );
  }
}
