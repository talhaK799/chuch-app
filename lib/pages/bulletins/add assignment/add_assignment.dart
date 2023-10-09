import 'dart:developer';

import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/add%20assignment/add_assignment_controller.dart';
import 'package:churchappenings/utils/truncateText.dart';
import 'package:churchappenings/widgets/custom_dropdown_form_field.dart';
import 'package:churchappenings/widgets/custom_elevated_button.dart';
import 'package:churchappenings/widgets/custom_text_field2.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class AddAssignmentPage extends StatelessWidget {
  // final AssignmentController assignmentController =
  //     Get.put(AssignmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: navigateToWidget(),
          ),
        ),
        body: GetBuilder<AssignmentController>(
            global: false,
            init: AssignmentController(),
            builder: (assignmentController) {
              if (assignmentController.loading) {
                return Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Assignment',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Select Assignment Type',
                        style: TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.bold),
                      ),
                      Obx(
                        () => Column(
                          children: [
                            RadioListTile(
                              activeColor: redColor,
                              title: Text('Member'),
                              value: 'Member',
                              groupValue:
                                  assignmentController.assignmentType.value,
                              onChanged: (value) {
                                assignmentController
                                    .setAssignmentType(value.toString());
                              },
                            ),
                            RadioListTile(
                              activeColor: redColor,
                              title: Text('Department'),
                              value: 'Department',
                              groupValue:
                                  assignmentController.assignmentType.value,
                              onChanged: (value) {
                                assignmentController
                                    .setAssignmentType(value.toString());
                              },
                            ),
                            RadioListTile(
                              activeColor: redColor,
                              title: Text('Designation'),
                              value: 'Designation',
                              groupValue:
                                  assignmentController.assignmentType.value,
                              onChanged: (value) {
                                assignmentController
                                    .setAssignmentType(value.toString());
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      CustomTextField2(
                        labelText: 'Title',
                        hintText: 'Title',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the title.';
                          }

                          return null;
                        },
                      ),
                      if (assignmentController.assignmentType.value == 'Member')
                        CustomTextField2(
                          labelText: 'Assignee',
                          hintText: 'Assignee',
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the Assignee.';
                            }

                            return null;
                          },
                        ),
                      if (assignmentController.assignmentType.value ==
                          'Department')
                        CustomDropdownField(
                          hint: 'Please select department ',
                          text: 'Department',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select department';
                            }
                            return null;
                          },
                          hintText: '',
                          selectedValue:
                              assignmentController.selecteddepartmentId,
                          onChanged: (v) {
                            //   controller.addguestm.requestedFacilityId = int.parse(v ?? "");
                            // log('message  ${controller.addguestm.requestedFacilityId}');
                          },
                          mitems:
                              assignmentController.dept.map((dynamic option) {
                            final truncatedName =
                                truncateText(option['name'], 20);
                            return DropdownMenuItem<String>(
                              value: option['id'].toString(),
                              child: Text(truncatedName),
                            );
                          }).toList(),
                        ),
                      if (assignmentController.assignmentType.value ==
                          'Designation')
                        CustomDropdownField(
                          hint: 'Please select designation ',
                          text: 'Designation:',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select designation.';
                            }
                            return null;
                          },
                          hintText: '',
                          selectedValue:
                              assignmentController.selecteddesignationId,
                          onChanged: (v) {
                            //   controller.addguestm.requestedFacilityId = int.parse(v ?? "");
                            // log('message  ${controller.addguestm.requestedFacilityId}');
                          },
                          mitems:
                              assignmentController.desig.map((dynamic option) {
                            final truncatedName =
                                truncateText(option['title'], 20);
                            return DropdownMenuItem<String>(
                              value: option['title'] ?? "",
                              child: Text(truncatedName),
                            );
                          }).toList(),
                        ),

                      SizedBox(
                        height: 300,
                        child: HtmlEditor(
                          controller: assignmentController.descController,
                          htmlEditorOptions: const HtmlEditorOptions(
                            shouldEnsureVisible: true,
                            hint: "Description",
                          ),
                          htmlToolbarOptions: const HtmlToolbarOptions(
                              toolbarPosition: ToolbarPosition.aboveEditor,
                              toolbarType: ToolbarType.nativeExpandable),
                        ),
                      ),
                      // CustomTextField2(
                      //   maxLines: 3,
                      //   labelText: 'Description',
                      //   hintText: 'Description',
                      //   keyboardType: TextInputType.text,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return 'Please enter the description.';
                      //     }

                      //     return null;
                      //   },
                      // ),
                      CustomTextField2(
                        labelText: 'Date ',
                        //   controller: assignmentController.dateController,
                        hintText:
                            "${assignmentController.selectedDate.toLocal()}"
                                .split(' ')[0],
                        readOnly: true,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(Icons.calendar_today),
                        onTap: () => assignmentController.selectDate(context),
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 32.0),
                      CustomElevatedButton(
                          onPressed: () {}, buttonText: 'Add Assignment'),
                    ],
                  ),
                ),
              );
            }));
  }
}
