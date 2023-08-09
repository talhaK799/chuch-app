import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/polling/create_poll_controller.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PermissionScreen extends StatelessWidget {
  PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePollController>(
        init: CreatePollController(),
        builder: (model) {
          return Scaffold(
            appBar: transparentAppbar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigateToWidget(),
                  5.height,
                  Text(
                    'Give Permission',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'to Your poll',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  20.height,
                  Column(
                    children: [
                      ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: model.permissions.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      model.isChange(
                                          model.permissions[index].isCheckBox ==
                                                  true
                                              ? false
                                              : true,
                                          index);
                                    },
                                    child: Icon(
                                      model.permissions[index].isCheckBox ==
                                              true
                                          ? Icons.check_box_outlined
                                          : Icons
                                              .check_box_outline_blank_outlined,
                                      size: 20,
                                    ),
                                  ),
                                  8.width,
                                  Text(
                                    "${model.permissions[index].title}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5,
                                    ),
                                  ),
                                  Spacer(),
                                  model.permissions[index].isShow == true
                                      ? Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .radio_button_checked_outlined,
                                              size: 20,
                                            ),
                                            4.width,
                                            Text(
                                              "Read",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                height: 1.5,
                                              ),
                                            ),
                                            10.width,
                                            GestureDetector(
                                              onTap: () {
                                                model.selectPermisionIsModify();
                                              },
                                              child: Icon(
                                                model.permissions[index]
                                                            .isModify ==
                                                        true
                                                    ? Icons
                                                        .radio_button_checked_outlined
                                                    : Icons.radio_button_off,
                                                size: 20,
                                              ),
                                            ),
                                            4.width,
                                            Text(
                                              "Modify",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                height: 1.5,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                              15.height
                            ],
                          );
                        },
                      ),
                      model.permissions[2].isCheckBox == true
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
                                                if (model.deptList[index]
                                                        .isSelect ==
                                                    true) {
                                                  model.isChangeDept(
                                                      false, index);
                                                } else {
                                                  model.isChangeDept(
                                                      true, index);
                                                }
                                              },
                                              child: Icon(
                                                model.deptList[index]
                                                            .isSelect ==
                                                        true
                                                    ? Icons
                                                        .radio_button_checked_outlined
                                                    : Icons
                                                        .radio_button_off_outlined,
                                                size: 16,
                                              ),
                                            ),
                                            4.width,
                                            Text(
                                              "${model.deptList[index].name}}",
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
                                  }),
                            )
                          : Container(),
                    ],
                  ),
                  20.height,
                  GestureDetector(
                    onTap: () {
                      model.createPollPermission();
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        color: redColor.shade800,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
