import 'package:churchappenings/api/pray.dart';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:comment_box/comment/comment.dart';

import 'outgoing/outgoing-page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrayerController extends GetxController {
  PrayAPI api = PrayAPI();
  bool loading = true;
  dynamic _data = [];
  var comments;
  dynamic get data => _data;
  // dynamic get comments => _comments;
  int offset = 0;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  onInit() async {
    super.onInit();
    await fetchPrayers();
    loading = false;
    update();
  }

  Future fetchPrayers() async {
    _data.addAll(await api.getPrayers(offset));
    // await getPryerComments(
    //   _data[0]['id'],
    // );
    offset = offset + 20;
  }

  getPryerComments(id) async {
    print('prayer id ==> $id');
    comments = await api.getDetailsOfPrays(id);
  }

  Future fetchMorePrayers() async {
    loading = true;
    update();
    _data.addAll(await api.getPrayers(offset));
    offset = offset + 20;
    loading = false;
    update();
  }

  // Add Pray should be unique
  Future addPray(int prayerId, String note) async {
    loading = true;
    update();
    print(note);
    await api.addPray(prayerId, note);
  }

  openBottomShit(int id, context) async {
    await getPryerComments(id);
    update();
    // TextEditingController noteController = TextEditingController();
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'Comments',
                style: TextStyle(
                  color: redColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: CommentBox(
                userImage: AssetImage('assets/person.png'),
                child: commentChild(),
                labelText: 'Write a comment...',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);

                    addPray(id, commentController.text);

                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                  update();
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: redColor,
                textColor: Colors.grey,
                sendWidget:
                    Icon(Icons.send_sharp, size: 30, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      // Container(
      //   color: Colors.white,
      //   height: 305,
      //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           'Add a note',
      //           style: TextStyle(
      //             fontWeight: FontWeight.w700,
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         TextFormField(
      //           maxLines: 3,
      //           autocorrect: true,
      //           decoration: InputDecoration(
      //             labelText: 'Description',
      //             border: OutlineInputBorder(),
      //           ),
      //           controller: noteController,
      //         ),
      //         SizedBox(height: 20),
      //         GestureDetector(
      // onTap: () {
      //   addPray(id, noteController.text);
      // },
      //           child: Container(
      //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //             decoration: BoxDecoration(
      //               color: redColor,
      //             ),
      //             child: Text(
      //               'Add',
      //               style: TextStyle(
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      barrierColor: Colors.grey.withOpacity(0.5),
      isDismissible: true,
    );
  }

  commentChild() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: comments['prayer_notes'].length,
        // filedata.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              title: Text(
                comments['prayer_notes'][index]["member"]["user"]["name"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                comments['prayer_notes'][index]["note"],
              ),
              // trailing: Text('00-00', style: TextStyle(fontSize: 10)),
            ),
          );
        },
      ),
    );
  }

  navigateToOutgoing() {
    Get.to(OutgoingPage());
  }
}
