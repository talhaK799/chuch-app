import 'dart:io';

import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/polling/create_poll_controller.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

class CreatePollPage extends StatelessWidget {
  CreatePollPage({super.key});
  // final voteController = Get.put(CreatePollController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreatePollController>(
      init: CreatePollController(),
      builder: (model) => Scaffold(
        appBar: transparentAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigateToWidget(),
                20.height,
                Text("Create New Poll"),
                30.height,
                customTextField(
                  labelText: "Title",
                ),
                customTextField(labelText: "Description", maxLines: 4),
                Obx(
                  () => showDateTime(
                      onTap: model.showStartDatePickerDialog,
                      selectedDate: model.selectedStartDate.value,
                      labelText: "Start Date"),
                ),
                Obx(
                  () => showDateTime(
                      onTap: model.showEndDatePickerDialog,
                      selectedDate: model.selectedEndDate.value,
                      labelText: "End Date"),
                ),
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
                model.selectedDropDownValue == "Text"
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
                                        child:
                                            Text("${model.optionList[index]}"),
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
                model.selectedDropDownValue == "Text"
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customTextField(
                            labelText: "Options",
                            controller: model.addOption,
                          ),
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
                          UnconstrainedBox(
                            child: Image.file(
                              File(model.imagePath!),
                              fit: BoxFit.cover,
                              height: 100,
                              width: 120,
                            ),
                          ),
                        ],
                      ),
                10.height,
                GestureDetector(
                  onTap: () {
                    //crete function calling
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
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$labelText"),
        5.height,
        TextFormField(
          controller: controller,
          maxLines: maxLines ?? null,
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
