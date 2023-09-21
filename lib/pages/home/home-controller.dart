import 'dart:developer';

import 'package:churchappenings/api/blog.dart';
import 'package:churchappenings/api/bulletin.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/top-carousel-menu.dart';
import 'package:churchappenings/pages/bulletins/single-bulletin/single-bulletin-page.dart';
import 'package:churchappenings/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:churchappenings/api/poll.dart';

class HomeController extends GetxController {
  ProfileAPI profileApi = ProfileAPI.to;
  BulletinAPI bulletinApi = BulletinAPI();
  PollAPI pollapi = PollAPI();
  BlogAPI blogApi = BlogAPI();
  String? churchLogo;
  Rx<bool> isLoading = false.obs;

  

  int currentCarouselSelected = 1;

  String name = "";
  var bulletins = [];

  var categories = [];

  List<TopCarouselMenu> topCarouselMenu = [
    TopCarouselMenu(
      id: 1,
      title: "Search",
      icon: "assets/icon/004-search.svg",
      child: [
        Child(
          title: "Find a church",
          icon: "assets/icon/001-wedding.svg",
          path: Routes.search,
        ),
        Child(
          title: "Find a Job ",
          icon: "assets/icon/013-job-search.svg",
          path: Routes.jobs,
        ),
        Child(
          title: "Find a Pastor",
          icon: "assets/icon/015-find.svg",
          path: Routes.pastorSearch,
        ),
        Child(
          title: "Find a Member",
          icon: "assets/icon/014-find-my-friend.svg",
          path: Routes.members,
        ),
        Child(
          title: "Find a Hospital",
          icon: "assets/icon/016-pin.svg",
        ),
      ],
    ),
    TopCarouselMenu(
      id: 2,
      title: "Show Gratitude",
      icon: "assets/icon/006-plant.svg",
      child: [
        Child(
          title: "Stewardship",
          icon: "assets/icon/021-donation.svg",
          path: Routes.stewardship,
        ),
        Child(
            title: "Community Outreach",
            icon: "assets/icon/022-global-network.svg",
            path: Routes.communityOutreach),
        Child(
          title: "Donate Services",
          icon: "assets/icon/023-customer-service-agent.svg",
        ),
      ],
    ),
    TopCarouselMenu(
      id: 3,
      title: "Information",
      icon: "assets/icon/007-news.svg",
      child: [
        Child(
          title: "Bulletin",
          icon: "assets/icon/024-planning.svg",
          path: Routes.bulletins,
        ),
        Child(
          title: "My Calender",
          icon: "assets/icon/025-calendar.svg",
          path: Routes.calendar,
        ),
        Child(
          title: "Member Events",
          icon: "assets/icon/027-calendar-2.svg",
          path: Routes.myevent,
        ),
        Child(
          title: "Announcements",
          icon: "assets/icon/028-megaphone.svg",
          path: Routes.announcements,
        ),

        Child(
          title: "About SDA Church",
          icon: "assets/icon/032-information.svg",
          path: Routes.aboutSDA,
        ),
        // Linking
        Child(
          title: "Favorite Churches",
          icon: "assets/icon/033-star.svg",
          path: Routes.favChurches,
        ),
        Child(
          title: "Guestbook",
          icon: "assets/icon/book.svg",
          path: Routes.guestbook,
        ),
        Child(
          title: "Help",
          icon: "assets/icon/help.svg",
        ),
      ],
    ),
    TopCarouselMenu(
      id: 4,
      title: "Operations",
      icon: "assets/icon/008-teamwork.svg",
      child: [
        Child(
          title: "My Departments",
          icon: "assets/icon/034-structure.svg",
          path: Routes.department,
        ),
        Child(
          title: "Invite users",
          icon: "assets/icon/035-email.svg",
          path: Routes.invite,
        ),
        Child(
          title: "Memeber Transfer",
          icon: "assets/icon/035-email.svg",
          path: Routes.transfer,
        ),
      ],
    ),
    TopCarouselMenu(
      id: 5,
      title: "Fellowship",
      icon: "assets/icon/009-group.svg",
      child: [
        Child(
          title: "Polling",
          icon: "assets/icon/vote.svg",
          path: Routes.polls,
        ),
        Child(
          title: "Live Stream",
          icon: "assets/icon/036-live-streaming.svg",
        ),
        Child(
          title: "Prayometer",
          icon: "assets/icon/038-speedometer.svg",
          path: Routes.prayerometer,
        ),
        Child(
          title: "Sermon Notes",
          icon: "assets/icon/039-writing.svg",
          path: Routes.sermonNotes,
        ),
        Child(
          title: "Birthday board",
          icon: "assets/icon/040-birthday-cake.svg",
          path: Routes.birthdayBoard,
        ),
        Child(
          title: "Photo Gallery",
          icon: "assets/icon/041-photo-gallery.svg",
          path: Routes.photoGallery,
        ),
      ],
    ),
  ];

  int _noOfPolls = 0;
  int get noOfPolls => _noOfPolls;
  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  onInit() async {
    log("checkkkkinggg::");
    name = profileApi.name;
    var churches = profileApi.churches;
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // print("Device ID => ${await deviceInfo.deviceInfo}");

    // _messaging.getToken().then((token) async {
    //   print("token is $token");
    //   // print("${await deviceInfo.iosInfo}");
    // });
    for (var i = 0; i < churches.length; i++) {
      print("logo$i => ${churches[i].logo}");
      if (churches[i].id == profileApi.selectedChurchId) {
        if (churches[i].logo != '') {
          churchLogo =
              "https://d35ottccmnskmu.cloudfront.net/churches/church-58/1661135900048-logo.png"; //churches[i].logo;
          // print("churchLogo => $churchLogo");
        }
      }
    }

    update();

    _noOfPolls = await pollapi.fetchNoOfPolls();
    update();

    await fetchBulletins();
    update();

    categories = await blogApi.getBlogCategories();
    update();
    super.onInit();
  }

  void navigateToBibles() {
    Get.toNamed(Routes.bibles);
  }

  void navigateToPolls() {
    Get.toNamed(Routes.polls);
  }

  // Future fetchBulletins() async {
  //   bulletins = await bulletinApi.getBulletins(profileApi.selectedChurchId);
  //   print(bulletins);
  // }

  Future fetchBulletins() async {
    try {
      isLoading.value = true;

      DateTime currentDate = DateTime.now();
      String formattedDate =
          "${currentDate.year}-${currentDate.month}-${currentDate.day}";
      print("CHECKKKK ::: $formattedDate");
      bulletins = await bulletinApi.fetchUpComingBulletins(formattedDate);
      isLoading.value = false;

      // bulletins = await bulletinApi.getBulletins(profileApi.selectedChurchId);
      print(bulletins);
    } catch (e) {
      isLoading.value = false;
    }
  }

  void setCurrentActive(int i) {
    currentCarouselSelected = i;
    update();
  }

  void openDrawer() {
    Get.toNamed(Routes.more);
  }

  void redirectToBulletin(String id) {
    Get.to(
      SingleBulletinPage(),
      arguments: {'bulletinId': id},
    );
  }
}
