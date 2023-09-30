import 'package:churchappenings/pages/search/visit-church/regiser_churches_details_screen.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:churchappenings/widgets/Dialogues/dialogue.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import './search-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';

import 'build-church-card.dart';
import 'build-search-option.dart';
import 'get-form.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = Get.put(SearchController());
  @override
  void initState() {
    // searchController.getMemberStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: WillPopScope(
        onWillPop: () async {
          showCustomDialog(context, 'Are you sure?', 'Do you want to log out?',
              () {
            searchController.logOut();
          });
          return false;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          searchController.navigateToFav();
                        },
                        icon: Icon(Icons.star),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Search Facilities',
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
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<SearchController>(
                builder: (controller) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            buildSearchByOption(
                              'City',
                              searchController.activeSearchBy,
                              searchController.handleSubMenuTap,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            buildSearchByOption(
                              'Name',
                              searchController.activeSearchBy,
                              searchController.handleSubMenuTap,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            buildSearchByOption(
                              'Location',
                              searchController.activeSearchBy,
                              searchController.handleSubMenuTap,
                            ),
                            buildSearchByOption(
                              'Register',
                              searchController.activeSearchBy,
                              searchController.handleSubMenuTap,
                            )
                          ],
                        ),
                        getForm(searchController.activeSearchBy),
                        SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: controller.loading
                              ? Center(child: CircularProgressIndicator())
                              : controller.registerChurch!
                                  ? ListView.builder(
                                      itemCount: controller.facilities.length,
                                      itemBuilder: (context, index) {
                                        final facility =
                                            controller.facilities[index];
                                        return
                                            //  Text(facility['name']);
                                            GestureDetector(
                                          onTap: () async {
                                            final localData = LocalData();
                                            localData.setString(
                                                'Church', facility['name']);
                                            localData.setInt(
                                                'Churchid', facility['id']);
                                            localData.setString('churchLogo',
                                                facility['logo'] ?? "null");
                                            // await controller.getMemberStatus();

                                            Get.to(
                                                ResisterChurchesDetailsScreen(
                                              facilities: facility,
                                            ));
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            margin: EdgeInsets.only(bottom: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.grey
                                                        .withOpacity(0.2)),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                facility['logo'] != null
                                                    ? Container(
                                                        height: 150,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: Image.network(
                                                                    facility[
                                                                            'logo'] ??
                                                                        "")
                                                                .image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 150,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          image:
                                                              DecorationImage(
                                                            image: Image.asset(
                                                                    'assets/placeholder-1000.png')
                                                                .image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                //    : Container(),
                                                SizedBox(height: 10),
                                                Text(
                                                  facility['name'] ?? "",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(height: 7),
                                                SizedBox(height: 7),
                                                Text(
                                                  facility['description'] ?? "",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: controller.churches.length,
                                      itemBuilder: (context, index) {
                                        final church =
                                            controller.churches[index];
                                        final images = controller.images;
                                        return buildChurchCard(
                                          controller.facilities,
                                          images,
                                          church,
                                          index,
                                          controller.fetchedImages,
                                        );
                                      },
                                    ),
                        ),
                      ],
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
