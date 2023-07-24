import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/more/profile/edit_profile/edit_profile_controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../build-enrolled-churches.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<EditProfileController>(
        init: EditProfileController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      GestureDetector(
                        onTap: () {
                          _.onSave();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                            color: redColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    _.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelText: 'Birthdate',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _.openDatePicker(context);
                        },
                        icon: Icon(
                          Icons.calendar_today,
                        ),
                      ),
                    ),
                    controller: _.dateController,
                    readOnly: true,
                  ),
                  SizedBox(height: 15),
                  DropdownSearch<String>(
                    items: _.skills,
                    onChanged: _.onChangeSelectedSkill,
                    selectedItem: _.selectedSkill,
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Employment Status: "),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: _.isEmployed,
                                onChanged: (vlaue) {
                                  _.onUpdateEmployment(1);
                                }),
                            Text("Employed"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          children: [
                            Radio(
                                value: 1,
                                groupValue: _.isUnemployed,
                                onChanged: (vlaue) {
                                  _.onUpdateEmployment(0);
                                }),
                            Text("Unemployed"),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  _.isEmployed == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Notify for New Jobs "),
                            Checkbox(
                                value: _.isNewJobNoti,
                                onChanged: (value) {
                                  _.updateNewJobNoti();
                                }),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 20),
                  Column(
                      children: _.churches.map(
                    (church) {
                      bool selected = false;
                      if (church.id == _.selectedChurch) selected = true;
                      return buildEnrolledChurches(church, selected, () {
                        _.updateSelectedChurch(church.id);
                      });
                    },
                  ).toList()),

                  ///!
                  ///
                  ///
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
