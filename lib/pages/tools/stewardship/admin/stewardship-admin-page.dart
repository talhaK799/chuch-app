import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/utils/format-date-time.dart';
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
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      GestureDetector(
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
                    'Approve Donations',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Column(
                    children: _.data.map<Widget>(
                      (item) {
                        List dateTime =
                            formatDateTime(DateTime.parse(item["date_time"]));

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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
