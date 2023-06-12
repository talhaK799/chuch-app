import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';

Container buildBottomActionButton(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 25),
    decoration: BoxDecoration(
      color: redColor,
    ),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
          Icon(Icons.arrow_right_alt, color: Colors.white),
        ],
      ),
    ),
  );
}
