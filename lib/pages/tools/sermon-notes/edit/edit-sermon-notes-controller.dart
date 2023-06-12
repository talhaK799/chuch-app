import 'dart:async';

import 'package:churchappenings/api/sermon-notes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:get/get.dart';

class EditSermonNotesController extends GetxController {
  late int id;
  final api = SermonNotesAPI();
  var note;
  bool loading = true;
  QuillController quillcontroller = QuillController.basic();
  final FocusNode editorFocusNode = FocusNode();
  bool saveButtonEnabled = true;

  onInit() async {
    super.onInit();
    id = Get.arguments['id'];

    note = await api.getNoteDetails(id);

    if (!note["no_data"]) {
      quillcontroller = QuillController(
        document: Document.fromJson(note["data"]),
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    loading = false;
    update();
  }

  Future saveNote() async {
    var convertedValue = quillcontroller.document.toDelta().toJson();

    api.updateNote(id, convertedValue);
    saveButtonEnabled = false;
    update();

    Timer(Duration(seconds: 10), () {
      saveButtonEnabled = true;
      update();
    });
  }
}
