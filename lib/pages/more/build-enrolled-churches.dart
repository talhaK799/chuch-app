import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/member-of.dart';
import 'package:flutter/material.dart';

Widget buildEnrolledChurches(MemberOfModel church, bool selected) {
  return GestureDetector(
    onTap: () {
      print(church.id);
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selected ? Colors.white : redColor,
        border: Border.all(color: redColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              church.name,
              style: TextStyle(
                  color: selected ? redColor : Colors.white, fontSize: 17),
            ),
          ),
          Container(
            height: 17,
            width: 17,
            decoration: BoxDecoration(
              border: Border.all(
                  color: selected ? redColor : Colors.white, width: 3),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          )
        ],
      ),
    ),
  );
}
