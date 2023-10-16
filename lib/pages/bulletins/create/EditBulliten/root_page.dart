import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/create/EditBulliten/edit_bulletin_controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class RootPageBulletinEdit extends StatefulWidget {
  const RootPageBulletinEdit({super.key});

  @override
  State<RootPageBulletinEdit> createState() => _RootPageBulletinEditState();
}

class _RootPageBulletinEditState extends State<RootPageBulletinEdit> {
  final controller = Get.put(EditBullitenController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: navigateToWidget(),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Details'),
              Tab(text: 'Assignments'),
              Tab(text: 'Responsibilities'),
              Tab(text: 'Previews'),
            ],
            indicatorColor: redColor,
            labelColor: redColor, 
            unselectedLabelColor:
                Colors.grey, 
            labelStyle: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold), // Customize text style
            unselectedLabelStyle:
                TextStyle(fontSize: 16.0), 
          ),
        ),
        body: TabBarView(
          children: controller.tabs,
        ),
      ),
    );
  }
}
