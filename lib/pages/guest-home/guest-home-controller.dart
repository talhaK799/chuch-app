import 'package:churchappenings/api/blog.dart';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/top-carousel-menu.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/authentication.dart';
import 'package:get/get.dart';

class GuestHomeController extends GetxController {
  var categories = [];
  BlogAPI blogApi = BlogAPI();
  ProfileAPI profileApi = ProfileAPI.to;

  String name = "";
  int currentCarouselSelected = 1;

  void setCurrentActive(int i) {
    currentCarouselSelected = i;
    update();
  }

  TopCarouselMenu topCarouselMenu = TopCarouselMenu(
    id: 1,
    title: "Church Tools",
    icon: "assets/icon/003-tool.svg",
    child: [
      Child(
        title: "Church",
        icon: "assets/icon/001-wedding.svg",
        path: Routes.search,
      ),
      Child(
        title: "Pastor",
        icon: "assets/icon/015-find.svg",
        path: Routes.pastorSearch,
      ),
    ],
  );

  // TopCarouselMenu topCarouselMenuRead = TopCarouselMenu(
  //   id: 1,
  //   title: "Church Tools",
  //   icon: "assets/icon/003-tool.svg",
  //   child: [
  //     Child(
  //       title: "Bibles",
  //       icon: "assets/icon/010-bible.svg",
  //       path: Routes.bibles,
  //     ),
  //     Child(
  //       title: "Songbook",
  //       icon: "assets/icon/011-music-book.svg",
  //       path: Routes.songbook,
  //     ),
  //   ],
  // );

  Future logOut() async {
    final auth = Authentication();
    await auth.signOut();
  }

  onInit() async {
    name = profileApi.name;
    categories = await blogApi.getBlogCategories();
    update();
    super.onInit();
  }

  List<TopCarouselMenu> topCarouselMenu2 = [
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
        // Child(
        //   title: "Find a Member",
        //   icon: "assets/icon/014-find-my-friend.svg",
        //   path: Routes.members,
        // ),
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
        // Child(
        //   title: "Stewardship",
        //   icon: "assets/icon/021-donation.svg",
        //   path: Routes.stewardship,
        // ),
        Child(
            title: "Community Outreach",
            icon: "assets/icon/022-global-network.svg",
            path: Routes.communityOutreach),
        // Child(
        //   title: "Donate Services",
        //   icon: "assets/icon/023-customer-service-agent.svg",
        // ),
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
        // Child(
        //   title: "My Calender",
        //   icon: "assets/icon/025-calendar.svg",
        //   path: Routes.calendar,
        // ),
        // Child(
        //   title: "Member Events",
        //   icon: "assets/icon/027-calendar-2.svg",
        //   path: Routes.myevent,
        // ),
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
        // Child(
        //   title: "Guestbook",
        //   icon: "assets/icon/book.svg",
        //   path: Routes.guestbook,
        // ),
        Child(
          title: "Help",
          icon: "assets/icon/help.svg",
        ),
      ],
    ),
    // TopCarouselMenu(
    //   id: 4,
    //   title: "Operations",
    //   icon: "assets/icon/008-teamwork.svg",
    //   child: [
    //     Child(
    //       title: "My Departments",
    //       icon: "assets/icon/034-structure.svg",
    //       path: Routes.department,
    //     ),
    //     Child(
    //       title: "Invite users",
    //       icon: "assets/icon/035-email.svg",
    //       path: Routes.invite,
    //     ),
    //     Child(
    //       title: "Memeber Transfer",
    //       icon: "assets/icon/035-email.svg",
    //       path: Routes.transfer,
    //     ),
    //   ],
    // ),

    TopCarouselMenu(
      id: 4,
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
        // Child(
        //   title: "Prayometer",
        //   icon: "assets/icon/038-speedometer.svg",
        //   path: Routes.prayerometer,
        // ),
        Child(
          title: "Sermon Notes",
          icon: "assets/icon/039-writing.svg",
          path: Routes.sermonNotes,
        ),
        // Child(
        //   title: "Birthday board",
        //   icon: "assets/icon/040-birthday-cake.svg",
        //   path: Routes.birthdayBoard,
        // ),
        Child(
          title: "Photo Gallery",
          icon: "assets/icon/041-photo-gallery.svg",
          path: Routes.photoGallery,
        ),
      ],
    ),
  ];
}
