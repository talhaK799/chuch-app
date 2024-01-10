import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:get/get.dart';

import 'outgoing-controller.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';

class OutgoingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: transparentAppbar(),
          body: GetBuilder<OutgoingController>(
            init: OutgoingController(),
            global: false,
            builder: (_) {
              if (_.loading) return Center(child: CircularProgressIndicator());

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        navigateToWidget(),
                        GestureDetector(
                          onTap: () => _.navigateToCreate(),
                          child: Text(
                            'Create',
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
                      'My Outgoing prayers',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    // Text(
                    //   'Church prayer request payers',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w300,
                    //     height: 1.5,
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    TabBar(
                      indicatorColor: redColor,
                      labelColor: redColor,
                      tabs: [
                        Tab(
                          text: "New Prayers",
                        ),
                        Tab(
                          text: "Previous Prayers",
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _.data.map<Widget>((e) {
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
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _.toggleIsAnswered(
                                                e["mark_answered"], e["id"]);
                                          },
                                          child: Text(
                                            e["mark_answered"]
                                                ? 'Mark as unanswered'
                                                : 'Mark as answered',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        GestureDetector(
                                          onTap: () {
                                            _.navigateToDetails(e["id"]);
                                          },
                                          child: Text(
                                            'View details',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _.recents.map<Widget>((e) {
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
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _.toggleIsAnswered(
                                                e["mark_answered"], e["id"]);
                                          },
                                          child: Text(
                                            e["mark_answered"]
                                                ? 'Mark as unanswered'
                                                : 'Mark as answered',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        GestureDetector(
                                          onTap: () {
                                            _.navigateToDetails(e["id"]);
                                          },
                                          child: Text(
                                            'View details',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: redColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
