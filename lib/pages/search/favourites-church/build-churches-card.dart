import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/church.dart';
import 'package:churchappenings/pages/search/favourites-church/favourites-church-controller.dart';
import 'package:churchappenings/pages/search/search-details/search-details-page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

Widget buildChurchCard(Church church) {
  final FavouritesChurchController controller = Get.find();
  navigateToDetailsPage() {
    Get.to(SearchDetailsPage(), arguments: {"id": church.id});
  }

  return Container(
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 1, color: Colors.grey.withOpacity(0.2)),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          church.name.toString(),
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
              initialRating: church.rating ?? 0.0,
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
              '(' + church.totalUserRatings.toString() + ')',
            )
          ],
        ),
        SizedBox(height: 7),
        Text(
          church.address.toString(),
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                navigateToDetailsPage();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'View',
                  style: TextStyle(
                    color: redColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                controller.removeChurchFromFav(church.id);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'Remove from favorites',
                  style: TextStyle(
                    color: redColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
