import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/departments/guest_chat_screen.dart';
import 'package:churchappenings/pages/tools/guestbook/guest_book_page.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/utils/truncateText.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'guest-home-controller.dart';

class GuestHomePage extends StatelessWidget {
  final controller = Get.put(GuestHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: navigateToWidget(),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              controller.openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 45,
                height: 45,
                child: Image(
                  image: AssetImage('assets/icon/menu.png'),
                  width: 75,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<GuestHomeController>(
        init: GuestHomeController(),
        global: false,
        builder: (_) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _.churchLogo != "null"
                              ? Container(
                                  width: 50,
                                  height: 50,
                                  child: Image(
                                    image: NetworkImage(_.churchLogo),
                                    fit: BoxFit.cover,
                                    // height: 100,
                                  ))
                              : Container(),

                          Text(
                            truncateText(_.churchName, 12),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),

                          // GestureDetector(
                          //   onTap: () {
                          //     _.logOut();
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(10),
                          //     decoration: BoxDecoration(
                          //       color: redColor,
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: Row(
                          //       children: [
                          //         Icon(
                          //           Icons.logout,
                          //           color: Colors.white,
                          //           size: 20,
                          //         ),
                          //         2.width,
                          //         Text(
                          //           'Log out',
                          //           style: TextStyle(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.w700,
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "Tools",
                //         style: TextStyle(
                //           fontWeight: FontWeight.w700,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _.topCarouselMenu2.map<Widget>((single) {
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
                          .topCarouselMenu2[_.currentCarouselSelected - 1].child
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

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            name: 'Departments',
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildQuickMenuItem(
                            name: "Stewardship",
                            assetUrl: 'assets/icon/021-donation.svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.toNamed(Routes.stewardship);
                            },
                          ),
                          buildQuickMenuItem(
                            name: "Donate Services",
                            assetUrl:
                                "assets/icon/023-customer-service-agent.svg",
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              // Get.toNamed(Routes.bulletins);
                            },
                          ),
                          buildQuickMenuItem(
                            name: "Guestbook",
                            assetUrl: "assets/icon/book.svg",
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              //  Get.toNamed(Routes.guestbook);
                              Get.to(GuestBookScreen());
                            },
                          ),
                        ],
                      ),
                      20.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            name: 'Chat',
                            assetUrl: 'assets/icon/Vector (1).svg',
                            bgColor: redColor.withOpacity(0.2),
                            action: () {
                              Get.to(GuestChatScreen());
                            },
                          ),
                          Container(
                            width: 80,
                          )

                          // buildQuickMenuItem(
                          //   name: 'Events',
                          //   assetUrl: 'assets/icon/027-calendar-2.svg',
                          //   bgColor: redColor.withOpacity(0.2),
                          //   action: () {
                          //     Get.toNamed(Routes.myevent);
                          //   },
                          // ),
                          // buildQuickMenuItem(
                          //   name: 'Calendar',
                          //   assetUrl: 'assets/icon/025-calendar.svg',
                          //   bgColor: redColor.withOpacity(0.2),
                          //   action: () {
                          //     Get.toNamed(Routes.calendar);
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: _.categories.map(
                //     (single) {
                //       return GestureDetector(
                //         onTap: () {
                //           Get.to(BlogPage(),
                //               arguments: {'blogName': single["name"]});
                //         },
                //         child: Container(
                //           margin:
                //               EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             image: DecorationImage(
                //               image: AssetImage('assets/sample-bulletin.jpeg'),
                //               fit: BoxFit.cover,
                //             ),
                //           ),
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
                //                   single["name"],
                //                   style: TextStyle(
                //                     color: Colors.white,
                //                     height: 1.5,
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

                // SizedBox(height: 20),
                // ListTile(
                //   leading: Icon(
                //     Icons.logout,
                //   ),
                //   title: Text(
                //     "Log out",
                //   ),
                //   trailing: Icon(Icons.arrow_right),
                //   onTap: () {
                //     _.logOut();
                //   },
                // ),
                SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildQuickMenuItem({
    required String name,
    required String assetUrl,
    required Color bgColor,
    required Function action,
  }) {
    return Center(
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
    );
  }
}
