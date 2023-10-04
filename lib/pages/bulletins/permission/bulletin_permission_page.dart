import 'dart:developer';
import 'package:churchappenings/pages/bulletins/permission/bulletin_permission_controller.dart';
import 'package:churchappenings/pages/polling/create_poll_controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BulletinPermissionPage extends StatefulWidget {
  BulletinPermissionPage({Key? key}) : super(key: key);

  @override
  _BulletinPermissionPageState createState() => _BulletinPermissionPageState();
}

class _BulletinPermissionPageState extends State<BulletinPermissionPage> {
  @override
  void initState() {
    Get.put(BulletinPermissionController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BulletinPermissionController>(
      init: BulletinPermissionController(),
      builder: (model) {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: navigateToWidget(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'Give Permission',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                Text(
                  'to Your bulletin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Obx(() => CheckboxListTile(
                          title: Text('Everyone'),
                          value: model.everyoneChecked.value ?? false,
                          onChanged: (newValue) {
                            model.toggleEveryone(newValue ?? false);
                          },
                        )),
                    Obx(() => CheckboxListTile(
                          title: Text('Facility Members'),
                          value: model.facilityMembersChecked.value ?? false,
                          onChanged: (newValue) {
                            model.toggleFacilityMembers(newValue ?? false);
                          },
                        )),
                    Obx(() => CheckboxListTile(
                          title: Text('Only Department'),
                          value: model.onlyDepartmentChecked.value ?? false,
                          onChanged: (newValue) {
                            model.toggleOnlyDepartment(newValue ?? false);
                          },
                        )),
                    model.showSubCheckboxes.value == true
                        ? SizedBox(
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              shrinkWrap: true,
                              itemCount: model.deptList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (model
                                                    .deptList[index].isSelect ==
                                                true) {
                                              model.isChangeDept(false, index);
                                              log('nnn');
                                            } else {
                                              model.isChangeDept(true, index);
                                              log('lll');
                                            }
                                          },
                                          child: Icon(
                                            model.deptList[index].isSelect ==
                                                    true
                                                ? Icons
                                                    .radio_button_checked_outlined
                                                : Icons
                                                    .radio_button_off_outlined,
                                            size: 16,
                                          ),
                                        ),
                                        Text(
                                          "${model.deptList[index].name}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            height: 1.5,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
