import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/create/bulletin-created-by-me-page.dart';

import 'postings/postings-page.dart';
import 'single-bulletin/single-bulletin-page.dart';

import 'bulletins-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BulletinsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<BulletinsController>(
          init: BulletinsController(),
          global: false,
          builder: (_) {
            if (_.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            navigateToWidget(),
                            GestureDetector(
                              onTap: () {
                                Get.to(BulletinCreatedByMePage());
                              },
                              child: Text(
                                'Create',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: redColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Bulletins',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'Create view bulletins',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 30),
                        Column(
                          children: _.bulletins.map<Widget>((bulletin) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20, top: 30),
                                  child: Text(
                                    bulletin['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: redColor,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                buildBoardTile('View', () {
                                  Get.to(
                                    SingleBulletinPage(),
                                    arguments: {'bulletinId': bulletin["id"]},
                                  );
                                }),
                                buildBoardTile('Public Postings', () {
                                  Get.to(
                                    PostingsPage(),
                                    arguments: {'bulletinId': bulletin["id"]},
                                  );
                                }),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  Container buildBoardTile(String linkTitle, Function action) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 2,
            color: redColor,
          ),
        ),
      ),
      child: ListTile(
        title: Text(linkTitle),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          action();
        },
      ),
    );
  }
}
