import 'package:flutter/material.dart';

import '../constants/red-material-color.dart';

customWhiteButton({onTap, title, buttonColor, textColor,isActive}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: redColor,
          ),
          borderRadius: BorderRadius.circular(10),
          color:isActive==true?redColor: primaryWhite),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: isActive==true?Colors.white: redColor),
      )),
    ),
  );
}
