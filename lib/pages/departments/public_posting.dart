import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';
import '../bulletins/postings/postings-page.dart';
import 'departments-controller.dart';

class PublicPosting extends StatelessWidget {
  const PublicPosting({super.key, required this.deptId});
  final String deptId;

  @override
  Widget build(BuildContext context) {
    // String deptId = Get.arguments['deptId'];
    // log("AB $deptId");

    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<DepartmentController>(
          init: DepartmentController(),
          global: false,
          builder: (_) {
            if (_.loading) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        navigateToWidget(),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Public Posting",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _.publicPosting.length,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 150,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () {
                                // ! will start from here
                                log("check id: ${_.publicPosting[index].id}");
                                Get.to(
                                  PostingsPage(),
                                  arguments: {
                                    'bulletinId':
                                        _.publicPosting[index].bulletin.id,
                                  },
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    _.publicPosting[index].bulletin.image
                                        .toString(),
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Message: ${_.publicPosting[index].message.toString()}'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      'Sender Name: ${_.publicPosting[index].senderName.toString()}'),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
