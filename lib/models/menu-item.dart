import 'package:flutter/material.dart';

class CMenuItem {
  String title;
  Function action;
  IconData icon;
  CMenuItem({
    required this.title,
    required this.action,
    required this.icon,
  });
}
