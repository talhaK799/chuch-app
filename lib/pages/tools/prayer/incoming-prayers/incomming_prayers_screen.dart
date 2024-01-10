import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/prayer/incoming-prayers/incomming_prayers_controller.dart';
import 'package:churchappenings/pages/tools/prayer/prayer-controller.dart';
import 'package:churchappenings/widgets/custom_button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncommingPrayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<IcncommingPrayerController>(
        global: false,
        init: IcncommingPrayerController(),
        builder: (_) {
          return _.loading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(height: 10),
                        Text(
                          'Prayer Management',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'Church prayer request or respond to the payers',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _.data.map<Widget>(
                            (e) {
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
                                    GestureDetector(
                                      onTap: () async {
                                        // _.openBottomShit(e["id"], context);
                                        await _.getPryerComments(e["id"]);
                                        _.update();
                                        Get.bottomSheet(
                                          Container(
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: Text(
                                                    'Comments',
                                                    style: TextStyle(
                                                      color: redColor,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   height: 20,
                                                // ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          'Comment as anonymous'),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Checkbox(
                                                        checkColor:
                                                            Colors.white,
                                                        activeColor: redColor,
                                                        value: _.anonymous,
                                                        onChanged: (val) {
                                                          _.handleOnChnageAnonymus(
                                                              val);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CommentBox(
                                                    userImage: AssetImage(
                                                        'assets/person.png'),
                                                    child: commentChild(_),
                                                    labelText:
                                                        'Write a comment...',
                                                    errorText:
                                                        'Comment cannot be blank',
                                                    withBorder: false,
                                                    sendButtonMethod: () {
                                                      if (_
                                                          .formKey.currentState!
                                                          .validate()) {
                                                        print(_
                                                            .commentController
                                                            .text);

                                                        _.addPray(
                                                            e["id"],
                                                            _.commentController
                                                                .text);

                                                        _.commentController
                                                            .clear();
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      } else {
                                                        print("Not validated");
                                                      }
                                                      _.update();
                                                    },
                                                    formKey: _.formKey,
                                                    commentController:
                                                        _.commentController,
                                                    backgroundColor: redColor,
                                                    textColor: Colors.grey,
                                                    sendWidget: Icon(
                                                        Icons.send_sharp,
                                                        size: 30,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          barrierColor:
                                              Colors.grey.withOpacity(0.5),
                                          isDismissible: true,
                                        );
                                      },
                                      child: Text(
                                        'Pray',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: redColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  commentChild(_) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: _.comments['prayer_notes'].length,
        // filedata.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              title: Text(
                _.comments['prayer_notes'][index]["member"]["user"]["name"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _.comments['prayer_notes'][index]["note"],
              ),
              // trailing: Text('00-00', style: TextStyle(fontSize: 10)),
            ),
          );
        },
      ),
    );
  }
}
