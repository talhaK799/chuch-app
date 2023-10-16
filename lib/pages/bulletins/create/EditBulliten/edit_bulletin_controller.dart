import 'package:churchappenings/pages/bulletins/create/EditBulliten/assignment_page.dart';
import 'package:churchappenings/pages/bulletins/create/EditBulliten/detail_page.dart';
import 'package:churchappenings/pages/bulletins/create/EditBulliten/preview_page.dart';
import 'package:churchappenings/pages/bulletins/create/EditBulliten/responsibilities_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class EditBullitenController extends GetxController{

  final List<Widget> tabs = [
    DetailPage(), 
    AssignmentPage(), 
    ResponsibilityPage(), 
    PreviewPage(), 
  ];




}