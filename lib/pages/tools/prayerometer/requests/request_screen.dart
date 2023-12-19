import 'package:churchappenings/pages/tools/prayerometer/requests/request_controller.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/red-material-color.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/navigate-back-widget.dart';
import '../../../../widgets/transparentAppbar.dart';
import '../../../../widgets/white_button.dart';
import 'add_request_screen.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<RequestController>(
        init: RequestController(),
        global: false,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // customButton(title: 'Previous Request'),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    customButton(
                        title: 'New Request',
                        onTap: () {
                          Get.to(
                            AddRequestScreen(),
                          );
                        }),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    // primary: false,
                    itemCount: 3,
                    itemBuilder: (context, index) => _postSection(context, _),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _postSection(context, _) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 5,
        top: 16,
      ),
      decoration: BoxDecoration(
          color: greyColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                // You can replace the image with the user's profile picture
                backgroundImage: AssetImage('assets/placeholder-1000.png'),
                radius: 30.0,
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text('@johndoe'),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  useSafeArea: true,
                  // isScrollControlled: true,

                  enableDrag: true,
                  builder: (context) {
                    return CommentBox(
                      userImage: AssetImage('assets/placeholder-1000.png'),
                      child: commentSection(_),
                      labelText: 'Write a comment...',
                      errorText: 'Comment cannot be blank',
                      withBorder: false,
                      sendButtonMethod: () {
                        if (_.formKey.currentState!.validate()) {
                          print(_.commentController.text);
                          // setState(() {
                          //   var value = {
                          //     'name': 'New User',
                          //     'pic':
                          //         'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                          //     'message': commentController.text,
                          //     'date': '2021-01-01 12:00:00'
                          //   };
                          //   filedata.insert(0, value);
                          // });
                          _.commentController.clear();
                          FocusScope.of(context).unfocus();
                        } else {
                          print("Not validated");
                        }
                      },
                      formKey: _.formKey,
                      commentController: _.commentController,
                      backgroundColor: redColor,
                      textColor: Colors.white,
                      sendWidget:
                          Icon(Icons.send_sharp, size: 30, color: Colors.white),
                    );
                  },
                );
              },
              child: Text('Comments'),
            ),
          ),
        ],
      ),
    );
  }

  commentSection(RequestController _) {
    return ListView.builder(
      itemCount: _.filedata.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                // Display the image in large form.
                print("Comment Clicked");
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: new BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: CommentBox.commentImageParser(
                    imageURLorPath: _.filedata[index].userImage,
                  ),
                ),
              ),
            ),
            title: Text(
              _.filedata[index].userName ?? "user",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_.filedata[index].message ?? ""),
            trailing: Text(_.filedata[index].date ?? '00-00',
                style: TextStyle(fontSize: 10)),
          ),
        );
      },
    );
  }
}
