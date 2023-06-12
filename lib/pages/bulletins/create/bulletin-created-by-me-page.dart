import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/create/events/manage-events-page.dart';
import 'package:churchappenings/pages/bulletins/create/responsibility/responsibility-page.dart';
import 'package:churchappenings/pages/bulletins/single-bulletin/single-bulletin-page.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add/add-bulletin-page.dart';
import 'bulletin-created-by-me-controller.dart';

class BulletinCreatedByMePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<BulletinCreatedByMeController>(
        global: false,
        init: BulletinCreatedByMeController(),
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          navigateToWidget(),
                          GestureDetector(
                            onTap: () {
                              Get.to(AddBulletingPage());
                            },
                            child: Text(
                              'Create Bulletin',
                              style: TextStyle(
                                color: redColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Draft bulletins',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: _.bulletins.map<Widget>((bulletin) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20, top: 30),
                                child: Text(
                                  bulletin['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: redColor,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              buildBoardTile('View', () {
                                Get.to(
                                  SingleBulletinPage(),
                                  arguments: {'bulletinId': bulletin["id"]},
                                );
                              }),
                              buildBoardTile('Assignments', () {
                                Get.to(
                                  ManageEventsPage(),
                                  arguments: {
                                    'bulletinId': bulletin["id"],
                                    "bulletinName": bulletin['name']
                                  },
                                );
                              }),
                              buildBoardTile('Responsibilities', () {
                                Get.to(
                                  ResponsibilityPage(),
                                  arguments: {
                                    'bulletinId': bulletin["id"],
                                    "bulletinName": bulletin['name'],
                                    "responsibility":
                                        bulletin['responsibility'],
                                  },
                                );
                              }),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Container buildBoardTile(String linkTitle, Function action) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          width: 2,
          color: redColor,
        ),
      ),
    ),
    child: ListTile(
      title: Text(linkTitle),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        action();
      },
    ),
  );
}
