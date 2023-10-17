import 'package:churchappenings/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class AssignmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionListView(
              title: 'Members',
              listView: ListView.builder(
                itemCount: 1,
                shrinkWrap:
                    true, // Allow the ListView to be scrollable if needed
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling in this ListView
                itemBuilder: (BuildContext context, int index) {
                  return CustomCard(
                      title: 'Zainab', assignee: 'Person', datetime: 'date');
                },
              ),
            ),
            SectionListView(
              title: 'Department',
              listView: ListView.builder(
                itemCount: 1,
                shrinkWrap:
                    true, // Allow the ListView to be scrollable if needed
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling in this ListView
                itemBuilder: (BuildContext context, int index) {
                  return CustomCard(
                      title: 'Zainab', assignee: 'Person', datetime: 'date');
                },
              ),
            ),
            SectionListView(
              title: 'Designation',
              listView: ListView.builder(
                itemCount: 1,
                shrinkWrap:
                    true, // Allow the ListView to be scrollable if needed
                physics:
                    NeverScrollableScrollPhysics(), // Disable scrolling in this ListView
                itemBuilder: (BuildContext context, int index) {
                  return CustomCard(
                      title: 'Zainab', assignee: 'Person', datetime: 'date');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionListView extends StatelessWidget {
  final String? title;

  final ListView listView;
  SectionListView({
    required this.title,
    required this.listView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title ?? "",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        listView,
      ],
    );
  }
}
