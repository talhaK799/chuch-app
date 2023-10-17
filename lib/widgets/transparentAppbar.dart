import 'package:flutter/material.dart';

PreferredSize transparentAppbar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(0.0),
    child: AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
  );
}
