import 'package:churchappenings/pages/more/more-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'build-enrolled-churches.dart';

class MorePage extends StatelessWidget {
//  final moreController = MoreController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<MoreController>(
            global: false,
            init: MoreController(),
            builder: (controller) {
              return ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(height: 30),
                        Text(
                          'Logged in as',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          controller.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 30),
                        //!
                        // Column(
                        //   children: _.churches.map(
                        //     (church) {
                        //       bool selected = false;
                        //       if (church.id == _.selectedChurch) selected = true;
                        //       return buildEnrolledChurches(church, selected, () {
                        //         _.updateSelectedChurch(church.id);
                        //       });
                        //     },
                        //   ).toList(),
                        // ),
                        controller.selectedChurchObj == null
                            ? Container()
                            : buildEnrolledChurches(
                                controller.selectedChurchObj!, true, () {
                                controller.updateSelectedChurch(
                                    controller.selectedChurch);
                              })
                        // controller.churches.length > 0
                        //     ? ListView.builder(
                        //         shrinkWrap: true,
                        //         itemCount: 1,
                        //         itemBuilder: (context, index) {
                        //           return
                        //         })
                        //     : Container()
                      ],
                    ),
                    //   },
                    // ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: controller.isMember == true
                        ? controller.moreMenuItems
                            .map(
                              (item) => Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: ListTile(
                                  leading: Icon(
                                    item.icon,
                                  ),
                                  title: Text(
                                    item.title,
                                  ),
                                  trailing: Icon(Icons.arrow_right),
                                  onTap: () {
                                    item.action();
                                  },
                                ),
                              ),
                            )
                            .toList()
                        : controller.guestMenuItems
                            .map(
                              (item) => Container(
                                margin: EdgeInsets.only(bottom: 15),
                                child: ListTile(
                                  leading: Icon(
                                    item.icon,
                                  ),
                                  title: Text(
                                    item.title,
                                  ),
                                  trailing: Icon(Icons.arrow_right),
                                  onTap: () {
                                    item.action();
                                  },
                                ),
                              ),
                            )
                            .toList(),
                  )
                ],
              );
            }));
  }
}
