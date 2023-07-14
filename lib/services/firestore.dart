import 'package:churchappenings/models/church.dart';

import 'authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreService extends GetxController {
  final Authentication auth = Authentication.to;
  static FirestoreService to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future addChurchToFav(Church data) async {
    String uid = await auth.getUserId;
    await _db
        .collection('users')
        .doc(uid)
        .collection('favouritePlaces')
        .doc(data.id)
        .set(
          data.toJson(),
        );
  }

  Future<List<Church>> fetchFavChurches() async {
    String uid = await auth.getUserId;
    QuerySnapshot results = await _db
        .collection('users')
        .doc(uid)
        .collection('favouritePlaces')
        .get();
    print(results.docs);
    return [];
  }

  Future removeChurchFromFav(String id) async {
    String uid = await auth.getUserId;
    await _db
        .collection('users')
        .doc(uid)
        .collection('favouritePlaces')
        .doc(id)
        .delete();
  }
}
