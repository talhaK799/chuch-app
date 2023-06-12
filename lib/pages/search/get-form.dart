import 'package:churchappenings/pages/search/search-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container getForm(String active) {
  final SearchController searchController = Get.find();

  if (active == 'City') {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: searchController.cityQuery,
        decoration: InputDecoration(
          hintText: 'eg. Atlanta, US',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              searchController.handleChurchesSearch(false);
            },
          ),
        ),
      ),
    );
  }

  if (active == 'Name') {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: searchController.nameQuery,
        decoration: InputDecoration(
          hintText: 'eg. Atlanta Berean SDA',
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              searchController.handleChurchesSearch(false);
            },
          ),
        ),
      ),
    );
  }

  return Container();
}
