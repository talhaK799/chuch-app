import 'package:churchappenings/api/blog.dart';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPublisherController extends GetxController {
  bool loading = true;
  BlogAPI blogAPI = BlogAPI();
  var blogs = [];

  onInit() async {
    blogs = await blogAPI.getPublisherBlogs();
    print(blogs);
    loading = false;
    update();

    super.onInit();
  }

  createBlog() {
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
                'Add a blog',
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
                onTap: () async {
                  if (noteController.text.length > 3) {
                    await blogAPI.createBlog(
                      noteController.text,
                    );

                    blogs = await blogAPI.getPublisherBlogs();
                    update();
                    Get.back();
                  }
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
