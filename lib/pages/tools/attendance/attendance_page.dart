import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/prayer/incoming-prayers/incomming_prayers_screen.dart';
import 'package:churchappenings/pages/tools/prayer/prayer-controller.dart';
import 'package:churchappenings/utils/extention.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../widgets/calender.dart';
import '../../../widgets/custom_button.dart';
import '../prayerometer/prayerometer-page.dart';
import 'attendance_controller.dart';

class AttendancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<AttendaceController>(
        global: false,
        init: AttendaceController(),
        builder: (_) {
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
                    ],
                  ),
                  20.height,
                  Text(
                    'Attendance Record',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      height: 1.5,
                    ),
                  ),

                  // TableCalendar(
                  //   rangeStartDay: DateTime.utc(2024, 1, 4),
                  //   rangeEndDay: DateTime.utc(2024, 1, 16),
                  //   firstDay: DateTime.utc(2010, 10, 16),
                  //   lastDay: DateTime.utc(2030, 3, 14),
                  //   focusedDay: DateTime.now(),
                  //   calendarStyle: CalendarStyle(
                  //       defaultTextStyle: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w700,
                  //     color: redColor,
                  //     height: 1.5,
                  //   )),
                  // ),

                  Calendar(
                    presents: _.presentDates,
                    // abssents: [
                    //   DateTime.utc(2024, 1, 4),
                    //   DateTime.utc(2024, 1, 8),
                    // ],
                  ),
                  30.height,
                  GestureDetector(
                    onTap: () {
                      _.takeAttendance();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: Center(
                          child: Text(
                        'Check In',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
