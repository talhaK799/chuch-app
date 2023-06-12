import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/utils/format-date-time.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';

import 'edit-sermon-notes-controller.dart';

class EditSermonNotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: transparentAppbar(),
        body: GetBuilder<EditSermonNotesController>(
          init: EditSermonNotesController(),
          global: false,
          builder: (_) {
            if (_.loading) {
              return Center(child: CircularProgressIndicator());
            }
            List<String> dateTime =
                formatDateTime(DateTime.parse(_.note["date"]));

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      GestureDetector(
                        onTap: () {
                          if (_.saveButtonEnabled) {
                            _.saveNote();
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: _.saveButtonEnabled ? redColor : Colors.grey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    _.note['title'],
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    dateTime[0],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  QuillToolbar.basic(
                    controller: _.quillcontroller,
                    showUnderLineButton: false,
                    showStrikeThrough: false,
                    showColorButton: false,
                    showBackgroundColorButton: false,
                    showListCheck: false,
                    showIndent: false,
                  ),
                  QuillEditor(
                    placeholder: 'Add content',
                    controller: _.quillcontroller,
                    focusNode: _.editorFocusNode,
                    readOnly: false,
                    autoFocus: false,
                    expands: false,
                    scrollController: ScrollController(),
                    scrollable: true,
                    padding: EdgeInsets.zero,
                    minHeight: 100,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
