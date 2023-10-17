import 'dart:io';
import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/bulletins/permission/bulletin_permission_page.dart';
import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add-bulleting-controller.dart';

class AddBulletingPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AddBulletingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<AddBulletingController>(
              builder: (_) {
                // if (_.loading)
                //   return Center(
                //     child: CircularProgressIndicator(),
                //   );

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          navigateToWidget(),
                          SizedBox(height: 10),
                          Text(
                            'Create Bulletin',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 30),
                          _.imagePath != null
                              ? Image.file(File(_.imagePath!))
                              : Container(),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              _.uploadEventImage();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: redColor),
                              ),
                              child: Center(
                                child: Text('Choose Image'),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            autocorrect: true,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                            controller: _.titleController,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            autocorrect: true,
                            decoration: InputDecoration(
                              labelText: 'Subtitle',
                              border: OutlineInputBorder(),
                            ),
                            controller: _.subtitleController,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            maxLines: 3,
                            autocorrect: true,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            controller: _.descriptionController,
                          ),
                          SizedBox(height: 15),
                          Text(
                            'Give Permission to your bulletin',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                          Obx(() => CheckboxListTile(
                                activeColor: redColor,
                                title: Text('Everyone'),
                                value: _.everyoneChecked.value,
                                onChanged: (newValue) {
                                  _.toggleEveryone(newValue ?? false);
                                },
                              )),
                          Obx(() => CheckboxListTile(
                                activeColor: redColor,
                                title: Text('Facility Members'),
                                value: _.facilityMembersChecked.value,
                                onChanged: (newValue) {
                                  _.toggleFacilityMembers(newValue ?? false);
                                },
                              )),
                          Obx(() => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CheckboxListTile(
                                  activeColor: redColor,
                                  title: Text('Save in Draft'),
                                  value: _.isDraft.value,
                                  onChanged: (newValue) {
                                    _.toggleDraft(newValue ?? false);
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            controller.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GestureDetector(
                    onTap: () => {
                      if (_formKey.currentState!.validate() &&
                          controller.permission != "")
                        {
                          controller.createBulletin(),
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('SomeThing went wrong')),
                          )
                        }
                      // Get.to(BulletinPermission()),
                    },
                    child: buildBottomActionButton('Create Bulletin'),
                  ),
          ],
        ),
      ),
    );
  }
}
