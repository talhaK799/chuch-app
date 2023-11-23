import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/stewardship/single/refund_page.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/utils/launch-url.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../home/home-page.dart';
import 'single-stewardship-controller.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleStewardshipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<SingleStewardshipController>(
        init: SingleStewardshipController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          List<Widget> list = [];

          for (int i = 0; i < _.data["donation_details"].length; i++) {
            String amount = _.data["donation_details"][i]["value"].toString();
            list.add(ListTile(
              title: Text(_.data["donation_details"][i]["option"]),
              trailing: Text("\$ $amount"),
            ));
          }

          List dateTime = formatDateTime(DateTime.parse(_.data["date_time"]));
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                          height: 30,
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: _.data["is_verified"]
                                ? Colors.green
                                : Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (_.data["is_verified"]) {
                                launchUrl(_.data["receipt_url"]);
                              }
                            },
                            child: Text(
                              _.data["is_verified"]
                                  ? 'Download Receipt'
                                  : 'Not Verified',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        _.data["is_verified"]
                            ? Container(
                                width: 100,
                                height: 30,
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(RefundPage());
                                  },
                                  child: Text(
                                    'Refund',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  '\$' + _.data["donation_amount"].toString(),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                Text(
                  dateTime[0],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 50),
                Column(
                  children: list,
                ),
                SizedBox(height: 50),
                _.data["is_verified"]
                    ? Text("")
                    : Column(
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 10),
                          //   decoration: BoxDecoration(
                          //     color: redColor,
                          //     borderRadius: BorderRadius.circular(10),
                          //   ),
                          //   child: ListTile(
                          //       title: Text(
                          //         "Pay online",
                          //         style: TextStyle(color: Colors.white),
                          //       ),
                          //       trailing: Icon(
                          //         Icons.arrow_right,
                          //         color: Colors.white,
                          //       ),
                          //       onTap: () {
                          //         _.onPayOnline();
                          //       }),
                          // ),
                          // SizedBox(height: 30),
                          // Text('or'),
                          // SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrImage(
                                data: _.id.toString(),
                                version: QrVersions.auto,
                                size: 200.0,
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                    title: Text(
                                      "Done",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_right,
                                      color: Colors.white,
                                    ),
                                    onTap: () {
                                      Get.offAll(HomePage());
                                      // _.onVerify();
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      )
              ],
            ),
          ));
        },
      ),
    );
  }
}
