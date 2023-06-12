import 'package:churchappenings/pages/tools/invite/invite-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<InviteController>(
        init: InviteController(),
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
                    'Invite Users',
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
                    'In ultricies sodales tortor, non laoreet nisl porta in. Integer imperdiet venenatis elit, eu tincidunt magna ultrices quis. Morbi nec feugiat ante. Mauris varius aliquam vestibulum. Nulla et tincidunt neque. Vivamus tincidunt vulputate augue, id pulvinar dolor laoreet at. Fusce efficitur suscipit tempor. Mauris dignissim nisi id elit blandit, non vehicula erat porta. Nulla sit amet justo felis. Aenean eu turpis sit amet urna sollicitudin rutrum. Praesent porta sem vitae ultrices fermentum.',
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
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          _.onSubmit();
                        },
                      ),
                    ),
                    controller: _.emailController,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
