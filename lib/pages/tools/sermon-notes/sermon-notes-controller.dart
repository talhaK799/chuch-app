import 'package:churchappenings/api/sermon-notes.dart';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/widgets/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit/edit-sermon-notes-page.dart';

class SermonNotesController extends GetxController {
  final api = SermonNotesAPI();
  bool loading = true;
  var notes = [];

  TextEditingController query = TextEditingController();

  onInit() async {
    super.onInit();
    await getNotes();
    loading = false;
    update();
  }

  Future getNotes() async {
    notes = await api.getAllNotes();
  }

  Future createNote(String title) async {
    var id = await api.createNote(title);
    await getNotes();
    update();
    Get.to(EditSermonNotesPage(), arguments: {"id": id});
  }

  Future deleteNote(int id, String name, BuildContext context) async {
    confirmationDialog(
      context,
      'Are you sure, you want to delete note - $name?',
      () async {
        await api.deleteNote(id);
        await getNotes();
        update();
      },
    );
  }

  Future search() async {
    notes = await api.getSearchedNotes(query.text);
    update();
  }

  openBottomShit() {
    TextEditingController noteController = TextEditingController();
    Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 250,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add a note',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                autocorrect: true,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                controller: noteController,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  createNote(noteController.text);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: redColor,
                  ),
                  child: Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.grey.withOpacity(0.5),
      isDismissible: true,
    );
  }
}
