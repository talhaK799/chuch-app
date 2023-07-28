import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/poll.dart';
import 'package:churchappenings/pages/polling/vote-poll-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

Container pollCardBuilder(PollModel poll) {
  bool vottedAlready = false;

  if (poll.userPols.length == 1) {
    vottedAlready = true;
  }

  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          poll.title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 5),
        Html(data: poll.desc),
        // Text("data"
        //     // poll.desc,
        //     ),
        SizedBox(height: 15),
        vottedAlready
            ? Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: redColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Response - ' + poll.userPols[0].selectedOption.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.all(15),
              )
            : GestureDetector(
                onTap: () {
                  //Vote Poll Page
                  Get.to(VotePollPage(
                    poll: poll,
                  ));
                },
                child: Row(
                  children: [
                    Text(
                      'Vote now',
                      style: TextStyle(
                        color: redColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 7),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 16,
                      color: redColor,
                    ),
                  ],
                ),
              ),
      ],
    ),
  );
}
