import 'package:churchappenings/pages/departments/departments-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class AddDepartmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<DepartmentController>(
        init: DepartmentController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      IconButton(onPressed: () {}, icon: Icon(Icons.add))
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'All Departments',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Send joining request',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _.departments.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text("Name: ${_.departments[index].name}"),
                              subtitle:
                                  Html(data: "${_.departments[index].desc}"),
                              trailing: TextButton(
                                  onPressed: () {
                                    _.sendJoinRequest(_.departments[index].id!);
                                  },
                                  child: Text("Join",
                                      style: TextStyle(color: Colors.blue))),
                            ),
                            Divider()
                          ],
                        );
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
