// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/guest-home/guest-home-page.dart';
import 'package:churchappenings/pages/search/search-controller.dart';
import 'package:churchappenings/pages/search/visit-church/resigister_church_details_controller.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/rectangleiconButton.dart';
import 'package:flutter/material.dart';

import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class ResisterChurchesDetailsScreen extends StatefulWidget {
  final facilities;

  ResisterChurchesDetailsScreen({
    Key? key,
    required this.facilities,
  }) : super(key: key);

  @override
  State<ResisterChurchesDetailsScreen> createState() =>
      _ResisterChurchesDetailsScreenState();
}

class _ResisterChurchesDetailsScreenState
    extends State<ResisterChurchesDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: navigateToWidget(),
          ),
        ),
        body: GetBuilder<RegisterChurchDetailsController>(
            init: RegisterChurchDetailsController(),
            builder: (_) {
              if (_.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.facilities['name'] ?? "",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: redColor),
                        textAlign: TextAlign.center,
                      ),
                      Card(
                          color: Colors.white,
                          elevation: 20.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                widget.facilities['logo'] != null
                                    ? Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: Image.network(
                                                    widget.facilities['logo'] ??
                                                        '')
                                                .image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: Image.asset(
                                                    'assets/placeholder-1000.png')
                                                .image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                SizedBox(height: 16.0),
                                _buildInfoField(widget.facilities['name'] ?? "",
                                    Icons.person, 'Name'),
                                Divider(thickness: 2),
                                _buildInfoField(
                                    widget.facilities['country'] ?? "",
                                    Icons.public,
                                    'Country'),
                                Divider(thickness: 2),
                                _buildInfoField(
                                    widget.facilities['division'] ?? "",
                                    Icons.location_city,
                                    'Division'),
                                Divider(thickness: 2),
                                _buildInfoField(
                                    "${widget.facilities['territory'] ?? ""} ",
                                    Icons.map,
                                    "Territory"),
                                Divider(thickness: 2),
                                _buildInfoField(
                                    "${widget.facilities['description'] ?? ""} ",
                                    Icons.note,
                                    "Description"),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
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
                                            widget.facilities['id'] ?? "");
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
                                final localData = LocalData();

                                // localData.setString('Church', widget.facilities['name']);
                                // localData.setInt('Churchid', widget.facilities['id']);

                                Get.off(GuestHomePage());
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

Widget _buildInfoField(String label, IconData iconData, String heading) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                iconData,
                color: redColor,
              ),
              SizedBox(height: 4.0),
            ],
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
