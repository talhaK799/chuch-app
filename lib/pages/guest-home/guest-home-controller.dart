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
}
