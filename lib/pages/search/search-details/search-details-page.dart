import 'dart:developer';
import 'dart:typed_data';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/guest-home/guest-home-page.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/rectangleiconButton.dart';
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
                      buildChurchDetails(church, _),
                      _.registeredChurch == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: RectangularIconButton(
                                    icon: Icons.real_estate_agent_sharp,
                                    label: _.memberStatus.isNotEmpty
                                        ? _.memberStatus[0]['status']
                                        : 'Request Membership',
                                    //  label: 'Request for Membership' ,
                                    buttonColor: redColor,
                                    onPressed: _.memberTransferr == false
                                        ? () async {
                                            // await _.memberTransfer(widget.facilities['id']);
                                            if (_.memberStatus.isEmpty) {
                                              await _.memberTransfer(
                                                 );
                                            } else {
                                              log('Already requested');
                                            }
                                          }
                                        : () {
                                            log('Already requested...........');
                                          },
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: RectangularIconButton(
                                    icon: Icons.location_on,
                                    label: 'Visit Church',
                                    buttonColor: redColor,
                                    onPressed: () {
                                      //   final localData = LocalData();

                                      // localData.setString('Church', widget.facilities['name']);
                                      // localData.setInt('Churchid', widget.facilities['id']);

                                      Get.off(GuestHomePage());
                                    },
                                  ),
                                ),
                              ],
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
