import 'package:churchappenings/pages/more/profile/request_churches/request_church_controller.dart';
import 'package:churchappenings/widgets/custom_button.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestChurchPage extends StatelessWidget {
  const RequestChurchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<RequestChurchController>(
        init: RequestChurchController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigateToWidget(),
                SizedBox(height: 10),
                Text(
                  'Request for Church',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 6,
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                customButton(title: 'Submit'),
              ],
            ),
          );
        },
      ),
    );
  }
}
