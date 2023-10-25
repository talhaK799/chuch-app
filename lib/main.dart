import 'package:churchappenings/services/authentication.dart';
import 'package:churchappenings/services/firestore.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  await Firebase.initializeApp();
  Get.put<Authentication>(Authentication());
  Get.lazyPut(() => FirestoreService());
//  Get.lazyPut(()=>SearchController());
  Get.put<HasuraService>(HasuraService());
  runApp(MyApp());
}
