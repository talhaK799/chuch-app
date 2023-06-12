import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget bottomNavigationBar(String routeName) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color.fromRGBO(31, 31, 31, 1),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        itemBuilder(Icons.home, 'home', routeName),
        itemBuilder(Icons.calendar_today, 'calendar', routeName),
        itemBuilder(Icons.all_inbox, 'tools', routeName),
        itemBuilder(Icons.more_horiz, 'more', routeName),
      ],
    ),
  );
}

Widget itemBuilder(IconData icon, String key, String routeName) {
  bool active = false;
  if (routeName == key) active = true;

  return Expanded(
    child: GestureDetector(
      onTap: () {
        Get.offAllNamed(key);
      },
      child: Container(
        height: 85,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 25, right: 25),
        child: Column(
          children: [
            Icon(
              icon,
              color: active ? Colors.white : Colors.grey,
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              width: 4,
              height: 4,
              color: active ? Colors.white : Colors.transparent,
            ),
          ],
        ),
      ),
    ),
  );
}
