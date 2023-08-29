import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'guest-home-controller.dart';

class GuestHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hi ' + _.name,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _.logOut();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  2.width,
                                  Text(
                                    'Log out',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Welcome to Churchappenings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
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
                              Get.toNamed(Routes.guestbook);
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
                          Container(
                            width: 80,
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
