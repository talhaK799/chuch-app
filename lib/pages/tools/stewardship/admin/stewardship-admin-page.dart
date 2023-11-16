import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/widgets/custom_button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'single/single-stewardship-page.dart';
import 'stewardship-admin-controller.dart';

class StewardshipAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<StewardshipAdminController>(
        init: StewardshipAdminController(),
        builder: (_) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navigateToWidget(),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: redColor)),
                          child: GestureDetector(
                            onTap: () {
                              _.isAllCollections = !_.isAllCollections;
                              _.update();
                            },
                            child: Text(
                              _.isAllCollections
                                  ? 'Current Period'
                                  : 'All Collections',
                              style: TextStyle(
                                color: redColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: redColor)),
                          child: GestureDetector(
                            onTap: () {
                              // Scan
                              _.scanQrCodeDetails();
                            },
                            child: Text(
                              'Scan',
                              style: TextStyle(
                                color: redColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'Stewardship Admin',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                Text(
                  _.isAllCollections
                      ? 'All time collections'
                      : 'Current Period Collections',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w300, height: 1.5),
                ),
                SizedBox(height: 30),
                _.isAllCollections == false
                    ? Expanded(
                        child: Center(
                          child: Text(""),
                        ),
                      )
                    : Expanded(
                        child: ListView(
                          children: _.data.map<Widget>(
                            (item) {
                              List dateTime = formatDateTime(
                                  DateTime.parse(item["date_time"]));

                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Get.to(SingleAdminStewardshipPage(),
                                        arguments: {"id": item["id"]});
                                  },
                                  title: Text(dateTime[0]),
                                  subtitle: Text(
                                    '\$' + item["donation_amount"].toString(),
                                  ),
                                  trailing: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: item["is_verified"]
                                          ? Colors.green
                                          : Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      item["is_verified"]
                                          ? 'Verified'
                                          : 'Not Verified',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                SizedBox(height: 10),
                _.isAllCollections
                    ? Container()
                    : customButton(title: "Check in Collections", onTap: () {}),
                SizedBox(height: 10)
              ],
            ),
          );
        },
      ),
    );
  }
}
