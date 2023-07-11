import 'package:churchappenings/pages/departments/private_posting.dart';
import 'package:churchappenings/pages/departments/public_posting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/bottom-action-button.dart';
import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';

class DetailsDepartment extends StatelessWidget {
  const DetailsDepartment(
      {super.key, required this.name, required this.deptId});
  final String name;
  final String deptId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navigateToWidget(),
              ],
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.to(
                  () => PublicPosting(deptId: deptId),
                  arguments: {'deptId': deptId},
                );
              },
              child: buildBottomActionButton("Public Posting"),
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Get.to(
                  PrivatePosting(deptId: deptId),
                );
              },
              child: buildBottomActionButton("Private Posting"),
            ),
          ],
        ),
      ),
    );
  }
}