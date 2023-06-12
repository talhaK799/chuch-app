import 'package:churchappenings/pages/tools/member-transfer/member-transfer-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemberTransferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<MemberTransferController>(
        init: MemberTransferController(),
        global: false,
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  navigateToWidget(),
                  SizedBox(height: 10),
                  Text(
                    'Transfer Church',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'In ultricies sodales tortor, non laoreet nisl porta in. Integer imperdiet venenatis elit, eu tincidunt magna ultrices quis. Praesent porta sem vitae ultrices fermentum.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelText: 'Seach Church Name',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          _.onSubmit();
                        },
                      ),
                    ),
                    controller: _.nameController,
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: _.churches.map<Widget>((item) {
                      return ListTile(
                        title: Text(item["name"]),
                        subtitle: Text(item["address"]),
                        trailing: IconButton(
                          onPressed: () {
                            _.memberInvite(item["id"]);
                          },
                          icon: Icon(Icons.arrow_right),
                        ),
                      );
                    }).toList(),
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
