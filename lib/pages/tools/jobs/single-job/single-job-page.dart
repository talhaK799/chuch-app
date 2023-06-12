import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'single-job-controller.dart';

class SingleJobPage extends StatelessWidget {
  const SingleJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: transparentAppbar(),
      body: Container(
        width: double.infinity,
        child: GetBuilder<SingleJobController>(
          init: SingleJobController(),
          global: false,
          builder: (_) {
            if (_.loading) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            navigateToWidget(),
                            _.myJob
                                ? GestureDetector(
                                    onTap: () {
                                      _.deleteJob();
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: redColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Job posting',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          _.data["title"] + ' - ' + _.data["company_name"],
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Location', style: labelStyle),
                          subtitle:
                              Text(_.data["location"], style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Description', style: labelStyle),
                          subtitle: Text(_.data["description"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Name', style: labelStyle),
                          subtitle: Text(_.data["name"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Phone Number', style: labelStyle),
                          subtitle: Text(_.data["phone_no"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Email', style: labelStyle),
                          subtitle: Text(_.data["email"].toString(),
                              style: propertyStyle),
                        ),
                        ListTile(
                          title: Text('Link', style: labelStyle),
                          subtitle: Text(_.data["link"].toString(),
                              style: propertyStyle),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
