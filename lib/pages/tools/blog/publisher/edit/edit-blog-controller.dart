import 'dart:async';

import 'package:churchappenings/api/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

class EditBlogController extends GetxController {
  bool loading = true;
  BlogAPI blogAPI = BlogAPI();
  int id = 0;
  var blog;
  String selectedType = 'Money Matters';

  TextEditingController titleController = TextEditingController();
  QuillController quillcontroller = QuillController.basic();
  final FocusNode editorFocusNode = FocusNode();
  bool saveButtonEnabled = true;

  onInit() async {
    super.onInit();
    id = Get.arguments["id"];
    blog = await blogAPI.getSingleBlog(id);
    print(blog);
    titleController.text = blog["name"];
    if (!blog["no_data"]) {
      quillcontroller = QuillController(
        document: Document.fromJson(blog["content"]),
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    loading = false;
    update();
  }

  void selectType(String? value) {
    selectedType = value!;
    update();
  }

  Future saveBlog() async {
    var convertedValue = quillcontroller.document.toDelta().toJson();
    String category = blog["no_data"] ? selectedType : blog["category"];

    saveButtonEnabled = false;
    update();

    print(id);

    await blogAPI.saveBlog(
      id,
      titleController.text,
      convertedValue,
      category,
    );
    blog = await blogAPI.getSingleBlog(id);
    update();

    Timer(Duration(seconds: 10), () {
      saveButtonEnabled = true;
      update();
    });
  }

  Future togglePublish() async {
    await blogAPI.togglePublishBlog(id, blog["published"]);

    blog = await blogAPI.getSingleBlog(id);
    update();
  }
}
