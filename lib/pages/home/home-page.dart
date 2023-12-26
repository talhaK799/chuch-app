import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/blog/blog-page.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/strings.dart';
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
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _.openDrawer();
                          },
                          child: Image.asset(
                            '$icons/sidebar.png',
                            scale: 3.5,
                          ),
                        ),
                        SizedBox(width: 15),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Image.asset(
                            'assets/logo.png',
                            scale: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _.profileApi.selectedChurchName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: redColor,
                              height: 1.5,
                            ),
                          ),
                        ),
                        SizedBox(width: 2),
                        _.profileApi.selectedChurchLogo != null
                            ? Image(
                                image: NetworkImage(
                                    _.profileApi.selectedChurchLogo,
                                    scale: 5.5),
                                // height: 60,
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _.topCarouselMenu.map<Widget>((single) {
                          return GestureDetector(
                            onTap: () {
                              _.setCurrentActive(single.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: single.id == _.currentCarouselSelected
                                    ? redColor
                                    : lightGreyColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      single.icon,
                                      color:
                                          single.id == _.currentCarouselSelected
                                              ? Colors.white
                                              : greyColor2,
                                      width: 20,
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
                                        color: single.id ==
                                                _.currentCarouselSelected
                                            ? Colors.white
                                            : greyColor2,
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
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: _
                              .topCarouselMenu[_.currentCarouselSelected - 1]
                              .child
                              .map<Widget>((single) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(single.path);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: redColor,
                              ),
                              borderRadius: BorderRadius.circular(30),
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
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: bulletinsFeed(_),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView(
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.6 / 2,
                      ),
                      children: [
                        buildQuickMenuItem(
                          name: 'Sermon Notes',
                          assetUrl: 'assets/icon/Notes.png',
                          bgColor: redColor.withOpacity(0.2),
                          action: () {
                            Get.toNamed(Routes.sermonNotes);
                          },
                        ),
                        buildQuickMenuItem(
                          name: 'Bulletins',
                          assetUrl: 'assets/icon/bulletins.png',
                          bgColor: redColor.withOpacity(0.2),
                          action: () {
                            Get.toNamed(Routes.bulletins);
                          },
                        ),
                        buildQuickMenuItem(
                          name: 'My Departments',
                          assetUrl: 'assets/icon/department.png',
                          bgColor: redColor.withOpacity(0.2),
                          action: () {
                            Get.toNamed(Routes.department);
                          },
                        ),
                        buildQuickMenuItem(
                          name: 'Announcements',
                          assetUrl: 'assets/icon/announcement.png',
                          bgColor: redColor.withOpacity(0.2),
                          action: () {
                            Get.toNamed(Routes.announcements);
                          },
                        ),
                        buildQuickMenuItem(
                          name: 'Events',
                          assetUrl: 'assets/icon/events.png',
                          bgColor: redColor.withOpacity(0.2),
                          action: () {
                            Get.toNamed(Routes.myevent);
                          },
                        ),
                        buildQuickMenuItem(
                          name: 'Calendar',
                          assetUrl: 'assets/icon/Calendar2.png',
                          bgColor: redColor.withOpacity(0.2),
                          action: () {
                            Get.toNamed(Routes.calendar);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Container(
                  //   height: 50,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: _.categories.length,
                  //     itemBuilder: (context, index) {
                  //       var single = _.categories[index];
                  //       return
                  //     },
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _.categories.isEmpty
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(BlogPage(), arguments: {
                                      'blogName': _.categories[0]["name"]
                                    });
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.only(right: 20),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    child: Text(
                                      _.categories[0]["name"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(BlogPage(), arguments: {
                                      'blogName': _.categories[1]["name"]
                                    });
                                  },
                                  child: Container(
                                    // margin: EdgeInsets.only(right: 20),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    child: Text(
                                      _.categories[1]["name"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   mainAxisAlignment: MainAxisAlignment.center,
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

                  SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

buildQuickMenuItem({
  required String name,
  required String assetUrl,
  required Color bgColor,
  required Function action,
}) {
  return GestureDetector(
    onTap: () {
      action();
    },
    child: Container(
      width: 115,
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 3,
              offset: Offset(0, 0))
        ],
        // boxShadow: [
        //   BoxShadow(
        //     color: greyColor,
        //     offset: Offset(1, 2),
        //   ),
        //   BoxShadow(
        //     color: greyColor,
        //     offset: Offset(2, 1),
        //   ),
        // ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              assetUrl,
              color: redColor,
              scale: 4,
              // width: 50,
            ),
          ),
          SizedBox(height: 7),
          Text(
            name,
            style: TextStyle(
              fontSize: 9,
              color: redColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
                ? Text(
                    "Not Found Upcoming Bulletins",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
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
