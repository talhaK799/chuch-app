import 'dart:convert';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

// final GlobalKey<NavigatorState> navigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: "navigator");

class _MyAppState extends State<MyApp> {
  late FirebaseMessaging messaging;

  final ProfileAPI profileApi = ProfileAPI.to;

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // final AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');
  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //   requestSoundPermission: true,
  //   requestBadgePermission: true,
  //   requestAlertPermission: true,
  //   // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  // );

  @override
  void initState() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((deviceToken) {
    //   print('\x1b[97m DEVICE TOKEN : ' + deviceToken.toString());
    //   print("===========================");
    //   print(deviceToken);
    //   setToken(deviceToken);
    //   notificationConfiguration();
    // });
    super.initState();
  }

  notificationConfiguration() async {
    print("@notificationConfiguration");

    //  await Permission.notification;
    // final InitializationSettings initializationSettings =
    //     InitializationSettings(
    //   android: initializationSettingsAndroid,
    //   iOS: initializationSettingsIOS,
    // );
    // await flutterLocalNotificationsPlugin.initialize(
    //   initializationSettings,
    //   onSelectNotification: onSelectNotification,
    // );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        print(message);
        RemoteNotification? notification = message.notification;
        // AndroidNotification? android = message.notification?.android;
        // showNotification(notification!.title!, notification.body!,
        //       json.encode(message.data));
        if (notification != null) {
          showNotification(notification.title!, notification.body!,
              json.encode(message.data));
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        onSelectNotification(json.encode(message.data));
      },
    );
  }

  Future onSelectNotification(String? payLoadData) async {
    print("@onNotificationSelected");
    dynamic payload = await json.decode(payLoadData!);
    if (payload != null && payload['storeId'] != null) {
      // homeController.storeId!.value = payload['storeId'];

      // Get.to(RestaurantDetailsScreen());
    }
  }

  showNotification(String title, String message, dynamic payload) async {
    // var android = new AndroidNotificationDetails(
    //   'channel id',
    //   'channel NAME',
    //   channelDescription: 'CHANNEL DESCRIPTION',
    //   priority: Priority.high,
    //   importance: Importance.max,
    //   playSound: true,
    // );

    // var iOS = new IOSNotificationDetails();

    // var platform = new NotificationDetails(iOS: iOS, android: android);
    // await flutterLocalNotificationsPlugin.show(
    //   0,
    //   title,
    //   message,
    //   platform,
    //   payload: payload,
    // );
  }

  setToken(String? deviceToken) async {
    profileApi.saveDeviceId(deviceToken!);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            useMaterial3: true,
            primarySwatch: redColor,
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)),
        debugShowCheckedModeBanner: false,
        title: 'Churchappenings',
        initialRoute: Routes.initial,
        getPages: Routes.pages);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Notification Trigerred ***** $message");

  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("@firebaseMessagingBackgroundHandler333");
  // print(
  //     '@onBackgroundMessageHanlder ==> Notification: ${message.notification}');
  // print('@onBackgroundMessageHanlder ==> Data: ${message.data}');
}

/// 
/// Send SNS notification to the end point
/// 

// {
// "GCM": "{ \"notification\": { \"body\": \"Sample message for Android endpoints\" },\"title\": \"Title\" } }"
// }