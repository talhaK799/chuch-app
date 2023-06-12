import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/pastor-calendar/manage/pastor-manage-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PastorManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PastorManageController>(
          init: PastorManageController(),
          global: false,
          builder: (_) {
            if (_.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return SingleChildScrollView(
              child: Padding(
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
                            _.handleSave();
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: redColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Manage pastor calendar',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      'Pastors appointment here',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 30),
                    ListTile(
                      title: Text('Add Manager'),
                      trailing: Icon(
                        Icons.arrow_right,
                      ),
                    ),
                    ListTile(
                      title: Text('Public Visibility'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handlePublicVisibilityUpdate(value);
                        },
                        value: _.publicVisibility,
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Days availibility',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text('Sunday'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handleDaysAvailibilityUpdate("Sunday", value);
                        },
                        value: _.daysAvailibility["Sunday"],
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    ListTile(
                      title: Text('Monday'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handleDaysAvailibilityUpdate("Monday", value);
                        },
                        value: _.daysAvailibility["Monday"],
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    ListTile(
                      title: Text('Tuesday'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handleDaysAvailibilityUpdate("Tuesday", value);
                        },
                        value: _.daysAvailibility["Tuesday"],
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    ListTile(
                      title: Text('Wednesday'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handleDaysAvailibilityUpdate("Wednesday", value);
                        },
                        value: _.daysAvailibility["Wednesday"],
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    ListTile(
                      title: Text('Thursday'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handleDaysAvailibilityUpdate("Thursday", value);
                        },
                        value: _.daysAvailibility["Thursday"],
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    ListTile(
                      title: Text('Friday'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handleDaysAvailibilityUpdate("Friday", value);
                        },
                        value: _.daysAvailibility["Friday"],
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    ListTile(
                      title: Text('Saturday'),
                      trailing: Switch(
                        onChanged: (bool value) {
                          _.handleDaysAvailibilityUpdate("Saturday", value);
                        },
                        value: _.daysAvailibility["Saturday"],
                        activeColor: redColor,
                        activeTrackColor: redColor.withOpacity(0.5),
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
