import 'dart:typed_data';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';

import 'build-church-details.dart';
import 'search-details-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchDetailsPage extends StatelessWidget {
  final controller = Get.put(SearchDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<SearchDetailsController>(
        init: SearchDetailsController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          } else {
            final church = _.church;
            Uint8List image = _.image;

            bool imagePresent = true;

            if (image.isEmpty) {
              imagePresent = false;
            }

            return Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      navigateToWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Church Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          height: 1.5,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        church.name!,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _.registeredChurch
                          ? Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                child: ListTile(
                                  onTap: () {
                                    _.navigateToVisitorForm();
                                  },
                                  title: Text(
                                    'Sign Our Guestbook',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      imagePresent
                          ? Image.memory(image)
                          : Image.asset('assets/placeholder-1000.png'),
                      SizedBox(
                        height: 15,
                      ),
                      buildChurchDetails(church),
                      _.registeredChurch == true
                          ? GestureDetector(
                              onTap: () {
                                // _.memberInvite(_.facilityId);
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                    color: redColor,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Center(
                                    child: Text(
                                  "Request Membership",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            )
                          : Container(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
