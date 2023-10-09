import 'package:churchappenings/pages/bulletins/create/EditBulliten/responsibility_controller.dart';
import 'package:churchappenings/widgets/custom_text_field2.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ResponsibilityPage extends StatefulWidget {
  @override
  _ResponsibilityPageState createState() => _ResponsibilityPageState();
}

class _ResponsibilityPageState extends State<ResponsibilityPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResponsibilitiesController>(
        //    global: false,
        init: ResponsibilitiesController(),
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Responsibilities Group',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Group name:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CustomTextField2(
                        controller: _.groupNameController,
                        labelText: 'Group name',
                        keyboardType: TextInputType.text,
                        hintText: 'Enter Group name'),
                    SizedBox(height: 16.0),
                    Text(
                      'Member:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CustomTextField2(
                        controller: _.memberNameController,
                        labelText: 'Member',
                        keyboardType: TextInputType.text,
                        hintText: 'Enter member'),
                    SizedBox(height: 8.0),
                    Text(
                      'Assigned as:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    CustomTextField2(
                        controller: _.assignedAsController,
                        labelText: 'Enter assigned role',
                        keyboardType: TextInputType.text,
                        hintText: 'Enter assigned role'),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _.addMember,
                      child: Text('Add'),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Members added:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (_.members.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _.members
                            .map((member) => ListTile(
                                  title: Text('Member: ${member['member']}'),
                                  subtitle: Text(
                                      'Assigned as: ${member['assignedAs']}'),
                                ))
                            .toList(),
                      ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: _.submit,
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
