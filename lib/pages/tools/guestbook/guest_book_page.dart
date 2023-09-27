
import 'package:churchappenings/constants/red-material-color.dart';

import 'package:churchappenings/pages/tools/guestbook/addguest.dart';
import 'package:churchappenings/pages/tools/guestbook/guest_details_screen.dart';
import 'package:churchappenings/pages/tools/guestbook/guestbook-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';

class GuestBookScreen extends StatefulWidget {
  const GuestBookScreen({super.key});

  @override
  State<GuestBookScreen> createState() => _GuestBookScreenState();
}

class _GuestBookScreenState extends State<GuestBookScreen> {
  DateTime now = DateTime.now();
//String formattedDate = now.toUtc().toIso8601String();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<GuestBookController>(
            init: GuestBookController(),
            builder: (_) {
              if (_.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        navigateToWidget(),
                        IconButton(
                            onPressed: () {
                              Get.to(AddGuestBook());
                            },
                            icon: Icon(Icons.add))
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Guest List',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _.guestData!.length ?? 2,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Get.to(DetailsScreen(personData: _.guestData![index]));
                            },
                            child: Card(
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'Guest Information',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: redColor,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    _buildInfoField(
                                        _.guestData![index].name ?? "",
                                        Icons.person),
                                    _buildInfoField(
                                        _.guestData![index].email ?? "",
                                        Icons.email),
                                    _buildInfoField(
                                        _.guestData![index].phoneNo ?? "",
                                        Icons.phone),
                                    _buildInfoField(
                                        "${_.guestData![index].country ?? ""}  ${_.guestData![index].state ?? ""}",
                                        Icons.location_on),
                                    // _buildInfoField(
                                    //     'Special Requests', Icons.note),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}

Widget _buildInfoField(String label, IconData iconData) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        iconData,
        color: redColor,
      ),
      SizedBox(width: 8.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8.0),
    ],
  );
}
