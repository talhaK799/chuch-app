import 'package:churchappenings/pages/bulletins/single-bulletin/single-bulletin-controller.dart';
import 'package:get/get.dart';

import './build-event-item.dart';
import './build-header.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

class SingleBulletinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: GetBuilder<SingleBulletinController>(
        init: SingleBulletinController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                buildHeader(
                  _.bulletin["name"],
                  _.bulletin["subtitle"],
                  _.bulletin["image"],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Html(
                    data: _.bulletin["description"],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.green.withOpacity(0.75),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                _.bulletin["assignments"] == null ||
                        _.bulletin["assignments"].isEmpty
                    ? Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("There are no events"),
                          ),
                        ],
                      )
                    : Column(
                        children: _.bulletin["assignments"].map<Widget>(
                          (assignment) {
                            return buildEventItem(
                                title: assignment["happening"]["title"],
                                assignedTo: assignment["assigne"],
                                time: assignment["happening"]["date_time"],
                                status: "PENDING");
                          },
                        ).toList(),
                      ),
                Column(
                  children: _.bulletin['responsibility'].map<Widget>(
                    (single) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: Colors.green.withOpacity(0.75),
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Text(
                              single["groupName"],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Column(
                            children: single["members"].map<Widget>(
                              (member) {
                                return ListTile(
                                  title: Text(member["member"]),
                                  subtitle: Text(member["assignedAs"]),
                                  trailing: Icon(Icons.mail),
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
                Container(
                  width: double.infinity,
                  color: Colors.green.withOpacity(0.75),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Departmental Postings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
                _.bulletin["dept_public_hostings"] == null ||
                        _.bulletin["dept_public_hostings"].isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                            "There are no departmental posts related to this Bulletin"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _.bulletin['dept_public_hostings'].map<Widget>(
                          (single) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    single["department"]["name"],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    single["message"],
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
