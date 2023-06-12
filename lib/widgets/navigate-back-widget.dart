import 'package:churchappenings/services/navigate-to-back.dart';
import 'package:flutter/material.dart';

Widget navigateToWidget({bool dark = false}) {
  return GestureDetector(
    onTap: () => navigateToBack(),
    child: Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: dark ? Colors.white : Colors.black,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Icon(
        Icons.keyboard_arrow_left,
        color: dark ? Colors.white : Colors.black,
      ),
    ),
  );
}
