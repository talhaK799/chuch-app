import 'package:flutter/material.dart';

Widget buildHeader(String title, String subtitle, String imageURL) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(imageURL),
        fit: BoxFit.cover,
      ),
    ),
    height: 500,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: Colors.black.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
