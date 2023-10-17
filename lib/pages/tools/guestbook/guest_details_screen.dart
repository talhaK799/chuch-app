import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/models/add_guestbook.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final GuestBookInputModel personData;

  DetailsScreen({required this.personData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: navigateToWidget(),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                personData.name ?? "",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: redColor),
                textAlign: TextAlign.center,
              ),
              Card(
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16.0),
                        _buildInfoField(
                            personData.name ?? "", Icons.person, 'Name'),
                        Divider(thickness: 2),
                        _buildInfoField(
                            personData.email ?? "", Icons.email, 'Email'),
                        Divider(thickness: 2),
                        _buildInfoField(
                            personData.phoneNo ?? "", Icons.phone, 'Phone no'),
                        Divider(thickness: 2),
                        _buildInfoField(
                            "${personData.country ?? ""}  ${personData.state ?? ""}",
                            Icons.location_on,
                            "Location"),
                        Divider(thickness: 2),
                        _buildInfoField(
                            personData.age.toString(), Icons.face, 'Age'),
                        Divider(thickness: 2),
                        _buildInfoField(personData.churchAffiliation ?? "",
                            Icons.account_balance, 'Church Affiliation'),
                        Divider(thickness: 2),
                        _buildInfoField(personData.description ?? "",
                            Icons.description, 'Description'),
                        Divider(thickness: 2),
                        _buildInfoField(personData.dateOfVisit ?? "",
                            Icons.calendar_today, 'Date of Visit'),
                        Divider(thickness: 2),
                        _buildInfoField(personData.description ?? "",
                            Icons.note, 'Special Request'),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoField(String label, IconData iconData, String heading) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                iconData,
                color: redColor,
              ),
              SizedBox(height: 4.0),
            ],
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
