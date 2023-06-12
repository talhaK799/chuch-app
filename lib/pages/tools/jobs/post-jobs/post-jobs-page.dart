import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/jobs/post-jobs/post-jobs-controller.dart';
import 'package:churchappenings/widgets/bottom-action-button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostJobsPage extends StatelessWidget {
  const PostJobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PostJobsController>(
        init: PostJobsController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        navigateToWidget(),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Post Job',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Job title',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.titleController,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.locationController,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Company or Facility',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.companyController,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.phoneNumberController,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Link',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.linkController,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          maxLines: 7,
                          autocorrect: true,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                          controller: _.descController,
                        ),
                        SizedBox(height: 25),
                        ListTile(
                          title: Text('Memeber Only'),
                          subtitle: Text(
                              '( If disabled, job can be viewed by everyone outside your church )'),
                          trailing: Switch(
                            onChanged: (bool value) {
                              _.setMembersOnly(value);
                            },
                            value: _.membersOnly,
                            activeColor: redColor,
                            activeTrackColor: redColor.withOpacity(0.5),
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _.postAJob();
                },
                child: buildBottomActionButton('Post Job'),
              ),
            ],
          );
        },
      ),
    );
  }
}
