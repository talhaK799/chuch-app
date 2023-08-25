import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/member-of.dart';
import 'package:churchappenings/models/menu-item.dart';
import 'package:churchappenings/pages/more/profile/profile-page.dart';
import 'package:churchappenings/routes.dart';
import 'package:churchappenings/services/authentication.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoreController extends GetxController {
  final Authentication auth = Authentication.to;
  final ProfileAPI profileApi = ProfileAPI.to;
  final localData = LocalData();

  String name = '';
  String church = "";
  List<Member> churches = [];
  Member? selectedChurchObj;
  int selectedChurch = 9999999;

  @override
  void onInit() async {
    name = profileApi.name;
    churches = profileApi.churches;
    selectedChurch = profileApi.selectedChurchId;
    for (int i = 0; i < churches.length; i++) {
      if (selectedChurch == churches[i].id) {
        selectedChurchObj = churches[i];
      }
    }

    update();
    super.onInit();
  }

  static void onTap() {
    print('Tapped');
  }

  static void logOut() async {
    final auth = Authentication();
    await auth.signOut();
  }

  updateSelectedChurch(int churchId) {
    print(churchId);
    localData.setInt("selected_church_id", churchId);
    selectedChurch = churchId;
    update();
  }

  List<CMenuItem> moreMenuItems = [
    CMenuItem(
      title: 'Profile',
      action: () {
        Get.to(ProfilePage());
      },
      icon: Icons.build_outlined,
    ),
    CMenuItem(
      title: 'About Church Happenings',
      action: () {
        Get.toNamed(Routes.aboutChurchappening);
      },
      icon: Icons.change_history_outlined,
    ),
    CMenuItem(
      title: 'About SDA Church',
      action: () {
        Get.toNamed(Routes.aboutSDA);
      },
      icon: Icons.info_outline,
    ),
    CMenuItem(
      title: 'Privacy Policy',
      action: () {
        Get.toNamed(Routes.privacyPolicy);
      },
      icon: Icons.privacy_tip_outlined,
    ),
    CMenuItem(
      title: 'Terms of Service',
      action: () {
        Get.toNamed(Routes.termsOfService);
      },
      icon: Icons.privacy_tip_outlined,
    ),
    CMenuItem(
      title: 'Help',
      action: () {},
      icon: Icons.help_center_outlined,
    ),
    CMenuItem(
      title: 'Logout',
      action: logOut,
      icon: Icons.exit_to_app,
    ),
    CMenuItem(
      title: 'App Version - v1.0',
      action: onTap,
      icon: Icons.mobile_friendly,
    ),
    CMenuItem(
      title: 'Member Transfer',
      action: () {
        Get.toNamed(Routes.memberTransfer);
      },
      icon: Icons.privacy_tip_outlined,
    ),
  ];
}
