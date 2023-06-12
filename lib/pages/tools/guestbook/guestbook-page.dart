import 'package:churchappenings/pages/tools/guestbook/guestbook-controller.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuestBookPage extends StatelessWidget {
  const GuestBookPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<GuestBookController>(
        init: GuestBookController(),
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      navigateToWidget(),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Guest List',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: _.list.map<Widget>(
                    (item) {
                      var dateTimeString = formatDateTime(
                        DateTime.parse(
                          item["date_of_visit"],
                        ),
                      );
                      return Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            if (_.havePermissionToViewDetails) {
                              _.navigateToDetails(item["id"]);
                            }
                          },
                          title: Text(item["name"]),
                          subtitle: Text(
                            dateTimeString[0] + ' - ' + dateTimeString[1],
                          ),
                          trailing: _.havePermissionToViewDetails
                              ? Icon(Icons.arrow_right)
                              : Container(width: 1),
                        ),
                      );
                    },
                  ).toList(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
