import 'package:churchappenings/pages/tools/pastor-search/book/pastor-book-appointment-page.dart';
import 'package:churchappenings/pages/tools/pastor-search/pastor-search-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastorSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PastorSearchController>(
        init: PastorSearchController(),
        global: false,
        builder: (controller) {
          Widget data = Container();
          if (!controller.loading) {
            data = SingleChildScrollView(
              child: Column(
                children: controller.pastors.map<Widget>((item) {
                  return Container(
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
                        Get.to(PastorBookAppointmentPage(), arguments: {
                          "pastorId": item["member"]["id"],
                          "pastorName": item["member"]["user"]["name"],
                          "churchName": item["member"]
                                  ["member_facility_permissions"][0]["facility"]
                              ["name"],
                        });
                      },
                      title: Text(item["member"]["user"]["name"]),
                      subtitle: Text(
                        item["member"]["member_facility_permissions"][0]
                            ["facility"]["name"],
                      ),
                      trailing: Icon(Icons.arrow_right_outlined),
                    ),
                  );
                }).toList(),
              ),
            );
          } else {
            data = Center(
              child: CircularProgressIndicator(),
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
                  'Find a pastor',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                Text(
                  'Book an appointment with your favorite pastor',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: controller.queryController,
                    decoration: InputDecoration(
                      hintText: 'Search by name',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          controller.handleSubmit();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(child: data),
              ],
            ),
          );
        },
      ),
    );
  }
}
