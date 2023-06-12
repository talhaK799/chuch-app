import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/blog/publisher/blog-publisher-controller.dart';
import 'package:churchappenings/pages/tools/blog/publisher/edit/edit-blog-page.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPublisherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<BlogPublisherController>(
        init: BlogPublisherController(),
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
                              _.createBlog();
                            },
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
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Blog Portal',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: _.blogs.map(
                          (single) {
                            return ListTile(
                              onTap: () {
                                Get.to(
                                  EditBlogPage(),
                                  arguments: {
                                    "id": single["id"],
                                  },
                                );
                              },
                              title: Row(
                                children: [
                                  Text(
                                    single["name"],
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: single["published"]
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Text(
                                single["category"].toString(),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              ),
                            );
                          },
                        ).toList(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
