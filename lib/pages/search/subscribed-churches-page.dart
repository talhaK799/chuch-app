import 'package:churchappenings/pages/search/subscribed-churches-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribedChurches extends StatelessWidget {
  final controller = Get.put(SubscribedChurchesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            navigateToWidget(),
            SizedBox(
              height: 10,
            ),
            Text(
              'Subscribed churches',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
            Text(
              'Select the option you want search by',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                height: 1.5,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: TextFormField(
                controller: controller.searchQuery,
                decoration: InputDecoration(
                  hintText: 'Search by church name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      controller.handleFetch();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<SubscribedChurchesController>(
                builder: (_) {
                  if (_.loading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: _.data.map<Widget>(
                        (e) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Colors.grey.withOpacity(0.3),
                                ),
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                _.navigateToDetails(e["place_id"]);
                              },
                              title: Text(
                                e["name"],
                              ),
                              subtitle: Text(e["address"]),
                              trailing: Icon(Icons.arrow_right),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
