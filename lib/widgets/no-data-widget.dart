import 'package:flutter/material.dart';

Widget noDataWidget(String message) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
    child: Center(child: Text(message)),
  );
}
