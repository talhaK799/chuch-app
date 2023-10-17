import 'package:churchappenings/constants/red-material-color.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

Container buildEventItem(
    {required String title,
    required String assignedTo,
    required String time,
    required String status}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(
          width: 2,
          color: redColor,
        ),
      ),
    ),
    child: ListTile(
      title: Text(title),
      subtitle: Text(assignedTo),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(status),
          Text(time.split("+")[0]),
        ],
      ),
    ),
  );
}

Container buildDynamicItem(
    {required String title,
    required String assignedTo,
    required String time,
    required String status,
    required List<String> assignees}) {
  return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 2,
            color: redColor,
          ),
        ),
      ),
      child: ExpandablePanel(
          header: Text(title),
          collapsed: Text(time.split("+")[0]),
          expanded: Expanded(
            child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: assignees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(assignees[index]),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(status),
                        Text(time.split("+")[0]),
                      ],
                    ),
                  );
                }),
          ))
      // Expandable(
      //     controller: ExpandableController(),
      //     collapsed: ListTile(
      //       title: Text(title),
      //       subtitle: Text(assignees[0]),
      //       trailing: Column(
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           Text(status),
      //           Text(time.split("+")[0]),
      //         ],
      //       ),
      //     ),
      //     expanded:
      // ListView.builder(
      //         itemCount: assignees.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             title: Text(title),
      //             subtitle: Text(assignees[index]),
      //             trailing: Column(
      //               crossAxisAlignment: CrossAxisAlignment.end,
      //               children: [
      //                 Text(status),
      //                 Text(time.split("+")[0]),
      //               ],
      //             ),
      //           );
      //         })
      //         )

      );
}
