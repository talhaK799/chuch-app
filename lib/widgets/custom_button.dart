import 'package:flutter/material.dart';

import '../constants/red-material-color.dart';

customButton({onTap, title, buttonColor, textColor}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor ?? redColor),
      child: Center(
          child: Text(
        title,
        style: TextStyle(color: textColor ?? Colors.white),
      )),
    ),
  );
}
