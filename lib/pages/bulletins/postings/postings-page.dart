import 'package:churchappenings/pages/bulletins/postings/posting-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PostingController>(
        init: PostingController(),
        builder: (_) {
          if (_.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_.selectedDepartment == '') {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigateToWidget(),
                  SizedBox(height: 10),
                  Text(
                    'Select Department',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'Public Posting',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  // Text(_);
                  SizedBox(height: 30),
                  Column(
                    children: _.departments.map<Widget>((dept) {
                      return ListTile(
                        title: Text(dept["department"]["name"]),
                        trailing: Icon(Icons.arrow_right),
                        onTap: () {
                          _.handleChangeDepartment(
                            dept["department"]["name"],
                            dept["department"]["id"],
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigateToWidget(),
                SizedBox(height: 10),
                Text(
                  'Publicly Posting as',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
                Text(
                  _.selectedDepartment,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _.postings.map<Widget>(
                          (post) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(post["department"]["name"]),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Text(post["message"]),
                                ),
                                SizedBox(height: 25),
                              ],
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ),
                _.permission.firstWhere(
                            (permission) =>
                                permission['permission_id'] ==
                                'DEPARTMENT_PUBLIC_POSTING',
                            orElse: () => {})['is_modify'] ==
                        true
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        width: double.infinity,
                        child: TextFormField(
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {
                                _.handleSubmit();
                              },
                            ),
                            hintText: 'Type here ...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          controller: _.messageController,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
