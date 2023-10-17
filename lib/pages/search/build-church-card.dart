import 'dart:typed_data';
import 'package:churchappenings/pages/search/search-details/search-details-page.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_place/google_place.dart';
import 'package:get/get.dart';

GestureDetector buildChurchCard(
  final facilities,
  List<Uint8List> images,
  SearchResult church,
  int index,
  bool fetchedImages,
) {
  bool imagePresent = true;

  if (fetchedImages && images[index].isEmpty) {
    imagePresent = false;
  }

  navigateToDetailsPage() {
    Get.to(SearchDetailsPage(), arguments: {"id": church.placeId});
  }

  return GestureDetector(
    onTap: () {
      final localData = LocalData();
      localData.setString('Church', church.name ?? "");
      localData.setString('Churchid', church.id ?? "");

      navigateToDetailsPage();
    },
    child: Container(
      padding: EdgeInsets.only(bottom: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          fetchedImages
              ? Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imagePresent
                          ? Image.memory(images[index]).image
                          : Image.asset('assets/placeholder-1000.png').image,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          SizedBox(height: 10),
          Text(
            church.name!.toString(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Text(
                church.rating.toString(),
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.w700),
              ),
              RatingBar.builder(
                initialRating: church.rating!,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemSize: 20,
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(width: 10),
              Text(
                '(' + church.userRatingsTotal.toString() + ')',
              )
            ],
          ),
          SizedBox(height: 7),
          Text(
            church.types!.first.capitalizeFirst! +
                ' - ' +
                (church.formattedAddress != null
                    ? church.formattedAddress.toString()
                    : church.vicinity.toString()),
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
