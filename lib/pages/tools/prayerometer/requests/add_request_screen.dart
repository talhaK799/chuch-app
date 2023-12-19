import 'package:churchappenings/widgets/custom_textform_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../../../widgets/custom_button.dart';
import '../../../../widgets/navigate-back-widget.dart';
import '../../../../widgets/transparentAppbar.dart';
import 'request_controller.dart';

class AddRequestScreen extends StatelessWidget {
  const AddRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<RequestController>(
        init: RequestController(),
        global: false,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navigateToWidget(),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Add New Request",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 10),
                CustomTextFormFeild(
                  labelText: 'Requsest Title',
                ),
                SizedBox(height: 10),
                CustomTextFormFeild(
                  labelText: 'Requsest Description',
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(
                    right: 150,
                  ),
                  child: customButton(title: 'Post Request'),
                ),

                // CustomTextFormFeild(
                //   labelText: 'Post Title',
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
