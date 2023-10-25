// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:churchappenings/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/add%20assignment/add_assignment_controller.dart';
import 'package:churchappenings/utils/truncateText.dart';
import 'package:churchappenings/widgets/custom_dropdown_form_field.dart';
import 'package:churchappenings/widgets/custom_elevated_button.dart';
import 'package:churchappenings/widgets/custom_text_field2.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';

class AddAssignmentPage extends StatefulWidget {
  var bulletinId;
  AddAssignmentPage({
    Key? key,
    required this.bulletinId,
  }) : super(key: key);
  @override
  State<AddAssignmentPage> createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  final _formKey = GlobalKey<FormState>();

  final AssignmentController controller = AssignmentController();
  @override
  void initState() {
    controller.assignment.bulletinId = widget.bulletinId;
    log('vvvvv${controller.assignment.bulletinId}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: GetBuilder<AssignmentController>(
            global: false,
            init: AssignmentController(),
            builder: (assignmentController) {
              assignmentController.assignment.bulletinId = widget.bulletinId;
              if (assignmentController.loading) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          UnconstrainedBox(child: navigateToWidget()),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 10,
                                right: 10,
                              ),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: redColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                "Please be mindful when creating assignments as, assignees may already have other assignments that may conflict.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: redColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      Text(
                        'Add Assignment',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16.0),

                      ///
                      /// assignment type selection
                      ///
                      assignmentTypeSelection(assignmentController),
                      SizedBox(height: 16.0),

                      ////
                      /// Assignee type selection
                      ///
                      Text(
                        'Select Assignee Type',
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
                                assignmentController.hint = false;
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
                                assignmentController.hint = false;
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
                        onChanged: (v) {
                          assignmentController.assignment.title = v;
                        },
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
                          controller: assignmentController.assignController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return assignmentController
                                          .isStandardAssignment ==
                                      false
                                  ? null
                                  : 'Please enter the Assignee.';
                            }

                            return null;
                          },
                          onChanged: (v) {
                            assignmentController.searchByEmail(v);
                          },
                        ),
                      assignmentController.searchedEmails.isNotEmpty &&
                              assignmentController.hint == true
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: double.infinity,
                              child: ListView.builder(
                                itemCount:
                                    assignmentController.searchedEmails.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      assignmentController
                                          .selectAssignee(index);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Text(assignmentController
                                              .searchedEmails[index].email ??
                                          ""),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Text(''),
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
                            assignmentController.assignment.deptid =
                                int.parse(v ?? "");
                            if (assignmentController.isStandardAssignment ==
                                false) {
                              for (int i = 0;
                                  i < assignmentController.dept.length;
                                  i++) {
                                if (assignmentController.dept[i]["id"]
                                        .toString() ==
                                    v) {
                                  print(
                                      "${assignmentController.dept[i]["name"]}");
                                  assignmentController.selectedAssignees.add(
                                      assignmentController.dept[i]["name"]);
                                  assignmentController.assignment.deptid =
                                      assignmentController.dept[i]["id"];
                                }
                              }
                              assignmentController.update();
                            }
                            //   controller.addguestm.requestedFacilityId = int.parse(v ?? "");
                            // log('message  ${controller.addguestm.requestedFacilityId}');
                          },
                          mitems:
                              assignmentController.dept.map((dynamic option) {
                            assignmentController.truncatedName =
                                truncateText(option['name'], 20);

                            return DropdownMenuItem<String>(
                              value: option['id'].toString(),
                              child: Text(assignmentController.truncatedName),
                            );
                          }).toList(),
                        ),

                      ////
                      /// Designation assignment
                      ///
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
                            print(v);
                            if (assignmentController.isStandardAssignment ==
                                false) {
                              for (int i = 0;
                                  i < assignmentController.desig.length;
                                  i++) {
                                if (assignmentController.desig[i]["title"]
                                        .toString() ==
                                    v) {
                                  if (assignmentController.selectedAssignees
                                      .contains(v)) {
                                  } else {
                                    assignmentController.selectedAssignees.add(
                                        assignmentController.desig[i]["title"]);
                                  }
                                }
                              }
                              assignmentController.update();
                            }
                            assignmentController.assignment.assignee = v;
                            log('$v');
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

                      ////
                      ///selected Assignees [When DYNAMIC is selected]
                      ///

                      assignmentController.isStandardAssignment == false
                          ? selectedAssignees(assignmentController)
                          : Container(),

                      ///
                      ////
                      ///Description area
                      ///
                      SizedBox(
                        height: 200,
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
                      CustomTextField2(
                        labelText: 'Date & Time',
                        //   controller: assignmentController.dateController,
                        hintText: "${assignmentController.formattedDateTime}"
                            .split(' ')[0],
                        readOnly: true,
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(Icons.calendar_today),
                        onTap: () {
                          assignmentController.selectDateAndTime(context);
                        },

                        onChanged: (value) {
                          assignmentController.formattedDateTime =
                              assignmentController.assignment.datetime;
                          log('${assignmentController.assignment.datetime}');
                        },
                      ),
                      SizedBox(height: 10.0),
                      assignmentController.isStandardAssignment == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Pre Confirmed: "),
                                Checkbox(
                                    value: assignmentController.isPreConfirmed,
                                    onChanged: (value) {
                                      assignmentController.isPreConfirmed =
                                          assignmentController.isPreConfirmed ==
                                                  true
                                              ? false
                                              : true;
                                      if (assignmentController.isPreConfirmed) {
                                        assignmentController.assignment.status =
                                            "CONFIRMED";
                                      } else {
                                        assignmentController.assignment.status =
                                            "PENDING";
                                      }
                                      assignmentController.update();
                                    })
                              ],
                            )
                          : Container(),
                      SizedBox(height: 32.0),
                      CustomElevatedButton(
                          onPressed: () {
                            assignmentController.assignment.datetime =
                                assignmentController.formattedDateTime;
                            assignmentController.assignment.type =
                                assignmentController.assignmentType.value;
                            assignmentController.assignment.assignee =
                                assignmentController.assignController.text;
                            log('${assignmentController.assignment.datetime}');

                            if (_formKey.currentState!.validate()) {
                              if (assignmentController.assignmentType.value ==
                                      'Member' ||
                                  assignmentController.assignmentType.value ==
                                      'Designation') {
                                assignmentController
                                    .addMemAndDesigAssignments(context);
                              } else if (assignmentController
                                      .assignmentType.value ==
                                  'Department') {
                                assignmentController
                                    .addAssignmentDepartment(context);
                              } else {
                                showSnackbar(
                                  context,
                                  message: 'SomeThing went wrong',
                                );
                              }
                            } else {
                              showSnackbar(
                                context,
                                message: 'Kindly fill all the fields',
                              );
                            }
                          },
                          buttonText: 'Add Assignment'),
                    ],
                  ),
                ),
              );
            }),
      )),
    );
  }

  selectedAssignees(AssignmentController controller) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        itemCount: controller.selectedAssignees.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(bottom: 6),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${controller.selectedAssignees[index]}"),
                      IconButton(
                          onPressed: () {
                            controller.selectedAssignees
                                .remove(controller.selectedAssignees[index]);
                            controller.update();
                          },
                          icon: Icon(Icons.clear))
                    ]),
                Divider()
              ],
            ),
          );
        });
  }

  assignmentTypeSelection(AssignmentController assignmentController) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            assignmentController.isStandardAssignment = true;
            assignmentController.assignment.assignmentType = "STANDARD";
            assignmentController.update();
          },
          child: Container(
            height: 30,
            decoration: BoxDecoration(
                color: assignmentController.isStandardAssignment
                    ? redColor
                    : redColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4)),
            child: Center(
                child: Text(
              "Standard Assignment",
              style: TextStyle(
                  fontSize: 13,
                  color: assignmentController.isStandardAssignment
                      ? Colors.white
                      : Colors.black),
            )),
          ),
        )),
        SizedBox(width: 20),
        Expanded(
            child: GestureDetector(
          onTap: () {
            assignmentController.isStandardAssignment = false;
            assignmentController.assignment.assignmentType = "DYNAMIC";
            assignmentController.update();
          },
          child: Container(
            decoration: BoxDecoration(
                color: assignmentController.isStandardAssignment == false
                    ? redColor
                    : redColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4)),
            height: 30,
            child: Center(
                child: Text(
              "Dynamic Assignment",
              style: TextStyle(
                  fontSize: 13,
                  color: assignmentController.isStandardAssignment == false
                      ? Colors.white
                      : Colors.black),
            )),
          ),
        ))
      ],
    );
  }
}
