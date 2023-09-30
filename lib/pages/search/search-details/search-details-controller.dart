import 'dart:developer';
import 'dart:typed_data';

import 'package:churchappenings/api/members.dart';
import 'package:churchappenings/api/search-church.dart';
import 'package:churchappenings/constants/api.dart';
import 'package:churchappenings/models/church.dart';
import 'package:churchappenings/pages/search/visit-church/visit-church-page.dart';
import 'package:churchappenings/services/firestore.dart';
import 'package:churchappenings/services/local_data.dart';
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

  final localData = LocalData();

  // int churchId = 0;
  bool? memberTransferr = false;
  memberTransfer() async {
    memberTransferr = await membersAPI.memberTransfer(facilityId);
    log('nnnnnnnnnnnnnnnnnnn$memberTransferr');
    update();
  }

  List<dynamic> memberStatus = [];

  getMemberStatus() async {
    memberStatus = await membersAPI.getMemberStatus(facilityId);
    log('kkkkkkkkkkkkkkk${memberStatus}');
    update();
  }

  onInit() async {
    // churchId = await localData.getInt('Churchid');
    // log('idd $churchId');

    update();
    log('$memberStatus');
    print("ID => ${await Get.arguments['id']}");
    id = await Get.arguments['id'];
    church = (await googlePlace.details.get(id))?.result ?? DetailsResult();
    print("church => ${church.id}");
    api.fetchChurchByPlaceID(id).then((value) {
      log('vvvvvvvvvvvvvvvvvvvvv $value');
      if (value.length == 1) {
        registeredChurch = true;
        facilityId = value[0]["id"];
        log('facility id $facilityId');
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

    await getMemberStatus();
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
