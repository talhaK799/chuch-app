import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/guestbook/addguest.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class GuestBookScreen extends StatefulWidget {
  const GuestBookScreen({super.key});

  @override
  State<GuestBookScreen> createState() => _GuestBookScreenState();
}

class _GuestBookScreenState extends State<GuestBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navigateToWidget(),
                IconButton(
                    onPressed: () {
                      Get.to(AddGuestBook());
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Guest List',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Guest Information',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: redColor,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          _buildInfoField('Name', Icons.person),
                          _buildInfoField('Email', Icons.email),
                          _buildInfoField('Phone Number', Icons.phone),
                          _buildInfoField('Address', Icons.location_on),
                          _buildInfoField('Special Requests', Icons.note),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildInfoField(String label, IconData iconData) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        iconData,
        color: redColor,
      ),
      SizedBox(width: 8.0),
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8.0),
    ],
  );
}
