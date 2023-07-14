import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/blog/blog-page.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../bulletins/single-bulletin/single-bulletin-page.dart';
import 'home-controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        global: false,
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _.openDrawer();
                        },
                        child: Container(
                          width: 45,
                          height: 45,
                          child: Image(
                            image: AssetImage('assets/icon/menu.png'),
                            width: 75,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: _.churchLogo != null
                              ? Image(
                                  image: NetworkImage(_.churchLogo!),
                                  height: 100)
                              : Container()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _.topCarouselMenu.map<Widget>((single) {
                      return GestureDetector(
                        onTap: () {
                          _.setCurrentActive(single.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: single.id == _.currentCarouselSelected
                                ? Colors.black
                                : redColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  single.icon,
                                  color: Colors.white,
                                  width: 23,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  single.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: _
                          .topCarouselMenu[_.currentCarouselSelected - 1].child
                          .map<Widget>((single) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(single.path);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: redColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                single.icon,
                                color: redColor,
                                width: 23,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                single.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList()),
                ),
                SizedBox(height: 30),
                bulletinsFeed(_),
                SizedBox(height: 30),
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          buildQuickMenuItem(
                            name: 'Sermon Notes',
                            assetUrl: 'assets/icon/039-writing.svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.toNamed(Routes.sermonNotes);
                            },
                          ),
                          buildQuickMenuItem(
                            name: 'Bulletins',
                            assetUrl: 'assets/icon/024-planning.svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.toNamed(Routes.bulletins);
                            },
                          ),
                          buildQuickMenuItem(
                            name: 'My Departments',
                            assetUrl: 'assets/icon/034-structure.svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.toNamed(Routes.department);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          buildQuickMenuItem(
                            name: 'Announcements',
                            assetUrl: 'assets/icon/028-megaphone.svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.toNamed(Routes.announcements);
                            },
                          ),
                          buildQuickMenuItem(
                            name: 'Events',
                            assetUrl: 'assets/icon/027-calendar-2.svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.toNamed(Routes.myevent);
                            },
                          ),
                          buildQuickMenuItem(
                            name: 'Calendar',
                            assetUrl: 'assets/icon/025-calendar.svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.toNamed(Routes.calendar);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _.categories.map(
                    (single) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(BlogPage(),
                              arguments: {'blogName': single["name"]});
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/sample-bulletin.jpeg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  single["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}

Expanded buildQuickMenuItem({
  required String name,
  required String assetUrl,
  required Color bgColor,
  required Function action,
}) {
  return Expanded(
    child: Center(
      child: GestureDetector(
        onTap: () {
          action();
        },
        child: Container(
          child: Column(
            children: [
              Container(
                width: 80,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    assetUrl,
                    color: redColor,
                    width: 50,
                  ),
                ),
              ),
              SizedBox(height: 7),
              Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Container bulletinsFeed(HomeController _) {
  return Container(
    child: Obx(() {
      return Container(
        child: _.isLoading.value == true
            ? Center(child: CircularProgressIndicator())
            : _.bulletins.isEmpty
                ? Center(
                    child: Text(
                      "Not Found Upcoming Bulletins",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upcoming Bulletins",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.to(
                            SingleBulletinPage(),
                            arguments: {'bulletinId': _.bulletins[0]["id"]},
                          );
                        },
                        child: Container(
                          height: 300,
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                _.bulletins.isNotEmpty
                                    ? _.bulletins[0]["image"].toString()
                                    : '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  height: 100,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _.bulletins.isNotEmpty
                                            ? _.bulletins[0]["name"].toString()
                                            : '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          height: 2.0,
                                          fontSize: 23,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        _.bulletins.isNotEmpty
                                            ? _.bulletins[0]["created_at"]
                                            : '',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Column(
                      //   children: _.bulletins.map<Widget>(
                      //     (bulletin) {
                      //       return GestureDetector(
                      //         onTap: () {
                      //           log("Bulletins ================================> ${bulletin["id"]}");
                      //           _.redirectToBulletin(bulletin["id"]);
                      //         },
                      //         child: Container(
                      //           margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(10),
                      //             image: DecorationImage(
                      //               image: NetworkImage(
                      //                 bulletin["image"],
                      //               ),
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //           width: double.infinity,
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //               color: Colors.black.withOpacity(0.75),
                      //               borderRadius: BorderRadius.circular(10),
                      //             ),
                      //             padding: EdgeInsets.symmetric(
                      //               horizontal: 20,
                      //               vertical: 30,
                      //             ),
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   bulletin["name"],
                      //                   style: TextStyle(
                      //                     color: Colors.white,
                      //                     height: 1.5,
                      //                   ),
                      //                 ),
                      //                 SizedBox(height: 30),
                      //                 Text(
                      //                   'September 10',
                      //                   style: TextStyle(
                      //                     color: Colors.white.withOpacity(0.7),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ).toList(),
                      // ),
                    ],
                  ),
      );
    }),
  );
}

// GetBuilder<HomeController>(
//               id: 'pollCount',
//               global: false,
//               init: HomeController(),
//               builder: (_) {
//                 if (_.noOfPolls > 0) {
//                   return Container(
//                     margin: EdgeInsets.only(top: 30, left: 15, right: 15),
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       border: Border(
//                         left: BorderSide(
//                           width: 2,
//                           color: redColor,
//                         ),
//                         right: BorderSide(
//                           width: 2,
//                           color: redColor,
//                         ),
//                       ),
//                     ),
//                     child: ListTile(
//                       onTap: () => homeController.navigateToPolls(),
//                       leading: FaIcon(
//                         FontAwesomeIcons.poll,
//                         color: redColor,
//                       ),
//                       title: Text(
//                         'Active Polls',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       trailing: Container(
//                           width: 30,
//                           height: 30,
//                           decoration: BoxDecoration(
//                             color: redColor,
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           child: Center(
//                             child: Text(
//                               _.noOfPolls.toString(),
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           )),
//                     ),
//                   );
//                 }
//                 return Container();
//               },
//             )
