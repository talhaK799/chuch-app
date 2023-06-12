import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';

import 'pray-details-controller.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrayDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PrayDetailsController>(
        init: PrayDetailsController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      Text(
                        'Total prayes - ' +
                            _.data["prayer_notes"].length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    _.data["title"],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    _.data["description"],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 50),
                  Column(
                    children: _.data["prayer_notes"].map<Widget>(
                      (item) {
                        return Container(
                          child: ListTile(
                            title: Text(item["member"]["user"]["name"]),
                            subtitle: Text(item["note"]),
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
