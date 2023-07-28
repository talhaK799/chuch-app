import 'package:churchappenings/pages/polling/create_poll_page.dart';
import 'package:churchappenings/pages/polling/poll-card-builder.dart';
import 'package:churchappenings/pages/polling/polls-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/no-data-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollsPage extends StatelessWidget {
  final pollsController = Get.put(PollsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigateToWidget(),
                SizedBox(height: 5),
                Text(
                  'Polls',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Church polls',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(CreatePollPage());
                      },
                      child: Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(child: Text("Create Poll")),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: GetBuilder<PollsController>(
                id: 'polls',
                builder: (_) {
                  if (_.polls.length > 0)
                    return ListView.builder(
                      itemCount: _.polls.length,
                      itemBuilder: (context, index) {
                        return pollCardBuilder(_.polls[index]);
                      },
                    );
                  else
                    return noDataWidget("No active polls found.");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
