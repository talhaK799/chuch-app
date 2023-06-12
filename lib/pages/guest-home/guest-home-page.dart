import 'package:churchappenings/constants/red-material-color.dart';
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // GestureDetector(
                      //   onTap: () {
                      //     _.openDrawer();
                      //   },
                      //   child: Container(
                      //     width: 45,
                      //     height: 45,
                      //     child: Image(
                      //       image: AssetImage('assets/icon/menu.png'),
                      //       width: 75,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Churchappenings',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        'Hi ' + _.name,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      children: _.topCarouselMenu.child.map<Widget>((single) {
                    return Expanded(
                      child: GestureDetector(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tools",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    "Log out",
                  ),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    _.logOut();
                  },
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
