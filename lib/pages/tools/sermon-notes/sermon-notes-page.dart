import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/sermon-notes/edit/edit-sermon-notes-page.dart';
import 'package:churchappenings/pages/tools/sermon-notes/sermon-notes-controller.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SermonNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<SermonNotesController>(
          init: SermonNotesController(),
          global: false,
          builder: (_) {
            if (_.loading) {
              return Center(child: CircularProgressIndicator());
            }
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
                        GestureDetector(
                          onTap: () {
                            _.openBottomShit();
                          },
                          child: Text(
                            'Add note',
                            style: TextStyle(
                              color: redColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Sermon Notes',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      'Create your personal notes',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Search previous notes',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _.search();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                      controller: _.query,
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: _.notes.length > 0
                          ? _.notes.map<Widget>(
                              (e) {
                                List<String> dateTime =
                                    formatDateTime(DateTime.parse(e["date"]));
                                return ListTile(
                                  onTap: () {
                                    Get.to(
                                      EditSermonNotesPage(),
                                      arguments: {
                                        "id": e["id"],
                                      },
                                    );
                                  },
                                  title: Text(e["title"]),
                                  subtitle: Text(
                                    dateTime[0] + ' ' + dateTime[1],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () {
                                      _.deleteNote(
                                          e["id"], e["title"], context);
                                    },
                                  ),
                                );
                              },
                            ).toList()
                          : [
                              SizedBox(height: 50),
                              Center(
                                child: Text("No Results"),
                              ),
                            ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
