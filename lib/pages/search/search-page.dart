import 'package:churchappenings/widgets/navigate-back-widget.dart';
import './search-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';

import 'build-church-card.dart';
import 'build-search-option.dart';
import 'get-form.dart';

class SearchPage extends StatelessWidget {
  final searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navigateToWidget(),
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
                  'Search By',
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
                        ],
                      ),
                      getForm(searchController.activeSearchBy),
                      SizedBox(
                        height: 25,
                      ),
                      Expanded(
                        child: controller.loading
                            ? Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                itemCount: controller.churches.length,
                                itemBuilder: (context, index) {
                                  final church = controller.churches[index];
                                  final images = controller.images;
                                  return buildChurchCard(
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
    );
  }
}
