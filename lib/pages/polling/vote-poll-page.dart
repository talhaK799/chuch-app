import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/poll.dart';
import 'package:churchappenings/pages/polling/vote-poll-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VotePollPage extends StatelessWidget {
  final PollModel poll;
  VotePollPage({required this.poll});

  final voteController = Get.put(VotePollController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    navigateToWidget(),
                    SizedBox(height: 30),
                    Text(
                      poll.title,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      poll.desc,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30),
                    GetBuilder<VotePollController>(
                      id: 'selected',
                      builder: (_) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: poll.options
                            .map(
                              (e) => buildOption(
                                e,
                                () {
                                  _.markSelected(e.id, e.option);
                                },
                                _.selected,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          submitButton(() => voteController.submitPoll(poll.id)),
        ],
      ),
    );
  }

  GestureDetector buildOption(Option e, Function onTap, int selected) {
    bool isSelected = false;
    if (e.id == selected) isSelected = true;

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              (e.id + 1).toString() + '.',
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400),
            ),
            SizedBox(width: 10),
            Text(
              e.option,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container submitButton(Function onTap) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        SizedBox(height: 20),
        Text('You can\'t change your response once submitted'),
        SizedBox(height: 15),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: redColor,
            ),
            child: Center(
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
