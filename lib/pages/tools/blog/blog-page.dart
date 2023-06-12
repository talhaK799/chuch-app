import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/blog/blog-controller.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<BlogController>(
        init: BlogController(),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          navigateToWidget(),
                          GestureDetector(
                            onTap: () {
                              _.navigateToPublisherPortal();
                            },
                            child: Text(
                              'Create Post',
                              style: TextStyle(
                                color: redColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        _.title,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: _.blogs.map<Widget>(
                    (single) {
                      List<String> dateTime =
                          formatDateTime(DateTime.parse(single['created_at']));

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(single["name"]),
                          subtitle: Text(dateTime[0] + ' ' + dateTime[1]),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () {},
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
