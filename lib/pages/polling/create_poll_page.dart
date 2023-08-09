import 'dart:io';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/permissions/permissions_screen.dart';
import 'package:churchappenings/pages/polling/create_poll_controller.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class CreatePollPage extends StatelessWidget {
  CreatePollPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GetBuilder<CreatePollController>(
      init: CreatePollController(),
      builder: (model) => Scaffold(
        appBar: transparentAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigateToWidget(),
                  20.height,
                  Text("Create New Poll"),
                  30.height,
                  customTextField(
                      labelText: "Title",
                      controller: model.titleController,
                      validator: (_) {
                        if (model.titleController.text.isEmpty) {
                          return "Please enter title";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(
                    height: 300,
                    child: HtmlEditor(
                      controller: model.descController,
                      htmlEditorOptions: const HtmlEditorOptions(
                        shouldEnsureVisible: true,
                        hint: "Description",
                      ),
                      htmlToolbarOptions: const HtmlToolbarOptions(
                          toolbarPosition: ToolbarPosition.aboveEditor,
                          toolbarType: ToolbarType.nativeExpandable),
                    ),
                  ),

                  Obx(
                    () => showDateTime(
                        onTap: model.showStartDatePickerDialog,
                        selectedDate: model.selectedStartDate.value,
                        labelText: "Start Date"),
                  ),

                  model.poll.startDate == null
                      ? Column(
                          children: [
                            2.height,
                            Text(
                              "Please Select Starting Date and Time",
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        )
                      : Container(),

                  // Obx(
                  //   () => showDateTime(
                  //       onTap: model.showEndDatePickerDialog,
                  //       selectedDate: model.selectedEndDate.value,
                  //       labelText: "End Date"),
                  // ),
                  10.height,
                  Text("Select Intput Option"),
                  5.height,
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(8),
                      isExpanded: true,
                      hint: Text("${model.selectedDropDownValue}"),
                      underline: Container(),
                      items: model.dropDownItem.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (val) {
                        model.changeDropDownValue(val!);
                        print(val);
                      },
                    ),
                  ),
                  10.height,
                  model.selectedDropDownValue == "text"
                      ? model.optionList.length != 0
                          ? SizedBox(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: model.optionList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Text(
                                              "${model.optionList[index]}"),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            model.removeItem(index);
                                          },
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.grey,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            )
                          : Container()
                      : Container(),
                  model.selectedDropDownValue == "text"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customTextField(
                                labelText: "Options",
                                controller: model.addOption,
                                validator: (_) {
                                  if (model.optionList.length == 0) {
                                    return "Please enter options";
                                  } else {
                                    return null;
                                  }
                                }),
                            15.height,
                            InkWell(
                              onTap: () {
                                model.addOptioToList();
                              },
                              child: Container(
                                  height: 40,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 1, color: Colors.black54),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add),
                                  )),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    model.uploadEventImage();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            width: 1, color: Colors.black54)),
                                    child: Center(
                                      child: Text(
                                        "Choose files",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.8),
                                      ),
                                    ),
                                  ),
                                ),
                                5.width,
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    model.imagePath != null
                                        ? "${model.imagePath}"
                                        : "No file Chosen",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            model.imagePath != null
                                ? UnconstrainedBox(
                                    child: Image.file(
                                      File(model.imagePath!),
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 120,
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                  10.height,
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        if (model.selectedDropDownValue == "image") {
                          model.uploadImageToServer();
                        }
                        if (model.poll.startDate != null) {
                          Get.to(PermissionScreen());
                        }
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: redColor.shade800,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Text(
                        "Create",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1),
                      )),
                    ),
                  ),
                  20.height,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showDateTime({final onTap, DateTime? selectedDate, String? labelText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.height,
        Text("$labelText"),
        5.height,
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate)
                      : 'yyyy-MM-dd',
                  style: TextStyle(fontSize: 16),
                ),
                Icon(Icons.calendar_today)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customTextField({
    String? labelText,
    final onChanged,
    final controller,
    final validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$labelText"),
        5.height,
        TextFormField(
          // enabled: false,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

// customTextField(
//                         labelText: "Start Date",
//                         hintText: "dd/mm/yyyy",
//                         icon: Icon(Icons.calendar_today),
//                         onTap: () {},
//                         readOnly: true),
//                     GestureDetector(
//                       onTap: _.showDatePickerDialog,
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 8, vertical: 15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: Colors.grey),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Obx(
//                               () => Text(
//                                 _.selectedDate.value != null
//                                     ? DateFormat('yyyy-MM-dd')
//                                         .format(_.selectedDate.value!)
//                                     : 'yyyy-MM-dd',
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                             Icon(Icons.calendar_today)
//                           ],
//                         ),
//                       ),
//                     ),
