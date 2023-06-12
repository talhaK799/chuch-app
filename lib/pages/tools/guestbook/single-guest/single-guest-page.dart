import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/guestbook/single-guest/single-guest-controller.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleGuestPage extends StatelessWidget {
  const SingleGuestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<SingleGuestController>(
        init: SingleGuestController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          TextStyle labelStyle = TextStyle(
            color: redColor,
            fontSize: 13,
            height: 1.5,
          );

          TextStyle propertyStyle = TextStyle(
            color: Colors.black,
            fontSize: 17,
            height: 1.5,
          );

          List<String> dateTime =
              formatDateTime(DateTime.parse(_.data["date_of_visit"]));

          return Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(height: 15),
                        Text(
                          'Visitation Request',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _.data["name"],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 20),
                        _.data["request_call"]
                            ? Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Requested call from pastor',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Date of Visit', style: labelStyle),
                          subtitle: Text(dateTime[0] + ' - ' + dateTime[1],
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Email', style: labelStyle),
                          subtitle: Text(_.data["email"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Phone Number', style: labelStyle),
                          subtitle: Text(_.data["phone_no"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Age', style: labelStyle),
                          subtitle: Text(_.data["age"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Address', style: labelStyle),
                          subtitle: Text(
                              _.data["state"].toString() +
                                  ', ' +
                                  _.data["country"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Church Affiliation', style: labelStyle),
                          subtitle: Text(
                              _.data["church_affiliation"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Purpose', style: labelStyle),
                          subtitle: Text(_.data["description"].toString(),
                              style: propertyStyle),
                        ),
                      ],
                    ),
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
