import 'dart:typed_data';

import 'package:churchappenings/api/members.dart';
import 'package:churchappenings/api/search-church.dart';
import 'package:churchappenings/constants/api.dart';
import 'package:churchappenings/models/church.dart';
import 'package:churchappenings/pages/search/visit-church/visit-church-page.dart';
import 'package:churchappenings/services/firestore.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

class SearchDetailsController extends GetxController {
  final FirestoreService db = FirestoreService.to;
  MembersAPI membersAPI = MembersAPI();
  final googlePlace = GooglePlace(GooglePlacesAPIKey);
  String id = '';
  int facilityId = 0;
  bool loading = true;
  DetailsResult church = DetailsResult();
  Uint8List image = Uint8List(0);
  SearchChurchAPI api = SearchChurchAPI();
  bool registeredChurch = false;

  onInit() async {
    print("ID => ${await Get.arguments['id']}");
    id = await Get.arguments['id'];
    church = (await googlePlace.details.get(id))?.result ?? DetailsResult();
    print("church => ${church.id}");
    api.fetchChurchByPlaceID(id).then((value) {
      if (value.length == 1) {
        registeredChurch = true;
        facilityId = value[0]["id"];
      }
      loading = false;
      update();
    });

    if (church.photos != null) {
      if (church.photos!.length != 0) {
        var firstPhoto = church.photos!.first;
        image = await getPlaceImage(
          firstPhoto.photoReference!,
          firstPhoto.width!,
          firstPhoto.height!,
        );
      } else {
        image = Uint8List(0);
      }
    } else {
      image = Uint8List(0);
    }
    update();

    super.onInit();
  }

  Future<Uint8List> getPlaceImage(
    String photoRef,
    int width,
    int height,
  ) async {
    Uint8List? result = await googlePlace.photos.get(photoRef, height, width);

    return result ?? Uint8List(0);
  }

  Future addChurchToFavourite() async {
    print("Add to favoutire");
    print(church.types);
    Church data = Church(
      id: church.placeId ?? '',
      name: church.name ?? '',
      address: church.formattedAddress ?? '',
      rating: church.rating ?? 0,
      totalUserRatings: church.userRatingsTotal ?? 0,
      type: church.types == null
          ? "Church"
          : church.types!.first.capitalizeFirst ?? 'Church',
      imageRef: church.photos == null
          ? ''
          : church.photos!.first.photoReference ?? '',
    );
    db.addChurchToFav(data);
  }

  // memberInvite(int id) async {
  //   await membersAPI.memberTransfer(id);
  // }

  navigateToVisitorForm() async {
    Get.to(VisitChurchPage(), arguments: {
      "facilityId": facilityId,
      "churchName": church.name,
    });
  }
}
