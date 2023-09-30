import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/search/search-details/search-details-controller.dart';
import 'package:churchappenings/utils/dial-call.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/utils/launch-map.dart';
import 'package:churchappenings/utils/launch-url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_place/google_place.dart';

Container buildChurchDetails(
    DetailsResult church, SearchDetailsController con) {
  final SearchDetailsController controller = Get.find();

  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              church.rating.toString(),
              style: TextStyle(
                fontSize: 17,
                color: Colors.amber,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 5),
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
              '(' + church.userRatingsTotal.toString() + ')',
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          church.formattedAddress ?? "",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w300,
            height: 1.5,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  buildLinks(
                    Icons.call,
                    'Call',
                    () {
                      dialCall(church.internationalPhoneNumber ?? "");
                    },
                  ),
                  buildLinks(
                    Icons.web,
                    'Website',
                    () {
                      launchUrl(church.website ?? "");
                    },
                  ),
                  buildLinks(
                    Icons.directions,
                    'Direction',
                    () {
                      launchMaps(
                        church.geometry!.location!.lat!,
                        church.geometry!.location!.lng!,
                      );
                    },
                  ),
                  buildLinks(
                    Icons.star,
                    'Favorites',
                    () {
                      controller.addChurchToFavourite();
                      Get.snackbar(
                        'Success',
                        'Added to favorites',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
              30.height,
              con.registeredChurch == false
                  ? Center(child: Text('This Church is not currently enrolled'))
                  : Text(''),
            ],
          ),
        ),
      ],
    ),
  );
}

Expanded buildLinks(IconData icon, String title, Function onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 7),
          Text(
            title,
            style: TextStyle(
              color: redColor,
            ),
          ),
        ],
      ),
    ),
  );
}

Expanded RequestMemberShip(IconData icon, String title, Function onTap) {
  return Expanded(
    child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: redColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 7),
          // Text(
          //   title,
          //   style: TextStyle(
          //     color: redColor,
          //   ),
          // ),
        ],
      ),
    ),
  );
}
