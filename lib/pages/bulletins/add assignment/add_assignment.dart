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
    controller.insrtdept.bulletinId = widget.bulletinId;
    log('vvvvv${controller.insrtdept.bulletinId}');
    super.initState();
  }

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
              assignmentController.insrtdept.bulletinId = widget.bulletinId;
              if (assignmentController.loading) {
                return Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
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
                            assignmentController.insrtdept.title = v;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter the title.';
                            }

                            return null;
                          },
                        ),
                        if (assignmentController.assignmentType.value ==
                            'Member')
                          CustomTextField2(
                            labelText: 'Assignee',
                            hintText: 'Assignee',
                            controller: assignmentController.assignController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the Assignee.';
                              }

                              return null;
                            },
                            onChanged: (v) {
                              assignmentController.gethintEmails(v);
                              // assignmentController.insrtdept.assignee = v;
                              log('$v...................');
                              assignmentController.hint = true;
                              log('message');
                            },
                          ),
                        assignmentController.emailList.isNotEmpty &&
                                assignmentController.hint == true
                            ? Container(
                                height: 70,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount:
                                      assignmentController.emailList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        assignmentController
                                                .assignController.text =
                                            assignmentController
                                                .emailList[index]['email'];
                                        assignmentController.insrtdept.uuid =
                                            assignmentController
                                                .emailList[index]['uuid'];
                                        log('${assignmentController.insrtdept.uuid}........');
                                        // assignmentController.insrtdept.deptid =
                                        //     assignmentController.emailList[index]
                                        //         ['uuid'];
                                      },
                                      child: Card(
                                        child: Text(assignmentController
                                            .emailList[index]['email']),
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
                              log('$v');

                              assignmentController.insrtdept.deptid =
                                  int.parse(v ?? "");
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
                              assignmentController.insrtdept.assignee = v;
                              log('$v');
                              //   controller.addguestm.requestedFacilityId = int.parse(v ?? "");
                              // log('message  ${controller.addguestm.requestedFacilityId}');
                            },
                            mitems: assignmentController.desig
                                .map((dynamic option) {
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
                                assignmentController.insrtdept.datetime;
                            log('${assignmentController.insrtdept.datetime}');
                          },
                        ),
                        SizedBox(height: 32.0),
                        CustomElevatedButton(
                            onPressed: () {
                              assignmentController.insrtdept.datetime =
                                  assignmentController.formattedDateTime;
                              assignmentController.insrtdept.type =
                                  assignmentController.assignmentType.value;
                              assignmentController.insrtdept.assignee =
                                  assignmentController.assignController.text;
                              log('${assignmentController.insrtdept.datetime}');

                              if (_formKey.currentState!.validate()) {
                                if (assignmentController.assignmentType.value ==
                                        'Member' ||
                                    assignmentController.assignmentType.value ==
                                        'Designation') {
                                  assignmentController
                                      .addMemDesignationAssign(context);
                                } else if (assignmentController
                                        .assignmentType.value ==
                                    'Department') {
                                  assignmentController
                                      .addAssignmentDepartment( context);
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
                ),
              );
            }));
  }
}
