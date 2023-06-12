import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/prayer/prayer-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PrayerController>(
        global: false,
        init: PrayerController(),
        builder: (_) {
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
                      GestureDetector(
                        onTap: () {
                          _.navigateToOutgoing();
                        },
                        child: Text(
                          'Outgoing',
                          style: TextStyle(
                            color: redColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Prayer Management',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Church prayer request or respond to the payers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _.data.map<Widget>(
                      (e) {
                        return Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e["title"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                e["description"],
                              ),
                              SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  _.openBottomShit(e["id"]);
                                },
                                child: Text(
                                  'Pray',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: redColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
