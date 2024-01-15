import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  Calendar({
    Key? key,
    required this.presents,
    // required this.abssents,
  }) : super(key: key);

  final List<DateTime> presents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: selectedDay,
      firstDay: DateTime(1990),
      lastDay: DateTime(2050),
      calendarFormat: format,
      // onFormatChanged: (CalendarFormat _format) {
      //   setState(() {
      //     format = _format;
      //   });
      // },
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekVisible: true,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, day, focusedDay) {
          for (int i = 0; i < presents.length; i++) {
            print(
                'day = ${day.day} ==> ${presents[i].day} Month=  ${day.month}==>${presents[i].month} Year= ${day.year}==>${presents[i].year}');
            if (day.day == presents[i].day &&
                day.month == presents[i].month &&
                day.year == presents[i].year) {
              print(
                  'calender = ${day.day} ==> ${presents[i].day} and  ${day.month}==>${presents[i].month} and ${day.year}==>${presents[i].year}');
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  '${day.day}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 15, 153, 107),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
          }
          return null;
        },
        defaultBuilder: (context, day, focusedDay) {
          if (day.isBefore(DateTime.now())) {
            for (int i = 0; i < presents.length; i++) {
              print(
                  'day = ${day.day} ==> ${presents[i].day} Month=  ${day.month}==>${presents[i].month} Year= ${day.year}==>${presents[i].year}');
              if (day.day == presents[i].day &&
                  day.month == presents[i].month &&
                  day.year == presents[i].year) {
                print(
                    'calender = ${day.day} ==> ${presents[i].day} and  ${day.month}==>${presents[i].month} and ${day.year}==>${presents[i].year}');
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 15, 153, 107),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '${day.day}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 243, 37, 54),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          // for (DateTime d in widget.abssents) {
          //   if (day.day == d.day &&
          //       day.month == d.month &&
          //       day.year == d.year) {
          //     return Padding(
          //       padding: const EdgeInsets.only(bottom: 16),
          //       child: Text(
          //         '${day.day}',
          //         style: const TextStyle(
          //           color: Color.fromARGB(255, 184, 9, 96),
          //           fontSize: 14,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     );
          //   }
          // }

          // return null;
        },
      ),

      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        defaultTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        weekendDecoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        weekendTextStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: true,
        titleCentered: true,
        formatButtonShowsNext: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
        formatButtonDecoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        formatButtonTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
