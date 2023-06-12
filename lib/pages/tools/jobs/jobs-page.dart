import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/jobs/jobs-controller.dart';
import 'package:churchappenings/pages/tools/jobs/post-jobs/post-jobs-page.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'single-job/single-job-page.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<JobsController>(
          init: JobsController(),
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
                                Get.to(PostJobsPage());
                              },
                              child: Text(
                                'Post Jobs',
                                style: TextStyle(
                                  color: redColor,
                                  fontSize: 16,
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
                          'Browse',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Jobs',
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
                    children: _.jobs.map<Widget>(
                      (e) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              Get.to(
                                SingleJobPage(),
                                arguments: {"id": e["id"]},
                              );
                            },
                            title: Text(e["title"] + ' - ' + e["company_name"]),
                            subtitle: Text(e["location"]),
                            trailing: Icon(Icons.arrow_right),
                          ),
                        );
                      },
                    ).toList(),
                  )
                ],
              ),
            );
          },
        ));
  }
}
