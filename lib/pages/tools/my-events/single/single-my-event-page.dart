import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/my-events/single/single-my-event-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleMyEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<SingleMyEventController>(
        global: false,
        init: SingleMyEventController(),
        builder: (_) {
          // Show loader
          if (_.loading) return Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      _.pastEvent
                          ? Container()
                          : GestureDetector(
                              onTap: () {},
                              child: Text('Edit',
                                  style: TextStyle(color: redColor)),
                            ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    _.details['event']['type'],
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    _.details['title'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  _.pastEvent
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                          ),
                          child: Center(child: Text('Event is completed')),
                        )
                      : Container(),
                  SizedBox(height: 10),
                  _.details['event']['image'] != ''
                      ? Image(image: NetworkImage(_.details['event']['image']))
                      : Container(),
                  buildSection('Date', _.date),
                  buildSection('Time', _.time),
                  buildSection('Description', _.details['description']),
                  SizedBox(height: 30),
                  Text(
                    'Invited Members',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  _.pastEvent
                      ? Container()
                      : TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter email',
                            suffixIcon: IconButton(
                              onPressed: () {
                                _.invite();
                              },
                              icon: Icon(Icons.send),
                            ),
                          ),
                          controller: _.inviteEmail,
                        ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _.details['event']['event_invitations']
                        .map<Widget>(
                          (invitation) => Container(
                            margin: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: Text(invitation['email']),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Column buildSection(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 30),
      Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 5),
      Text(
        content,
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontSize: 16,
        ),
      ),
    ],
  );
}
