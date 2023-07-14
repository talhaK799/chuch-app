import 'package:churchappenings/models/church.dart';
import 'package:get/get.dart';
import 'package:churchappenings/services/firestore.dart';

class FavouritesChurchController extends GetxController {
  final FirestoreService db = FirestoreService.to;
  List<Church> churches = [];
  bool loading = true;

  @override
  void onReady() async {
    churches = await db.fetchFavChurches();
    loading = false;
    update();
    super.onReady();
  }

  Future removeChurchFromFav(String id) async {
    await db.removeChurchFromFav(id);
    churches = await db.fetchFavChurches();

    Get.snackbar(
      'Success',
      'Removed from favorites',
      snackPosition: SnackPosition.BOTTOM,
    );
    update();
  }
}
