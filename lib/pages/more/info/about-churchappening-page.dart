import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';

class AboutChurchappeningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle paragraphStyle = TextStyle(
      fontSize: 16,
      height: 1.5,
    );

    TextStyle header = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      height: 1.5,
    );

    return Scaffold(
        appBar: transparentAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigateToWidget(),
                SizedBox(height: 10),
                Text(
                  'About Churchappening',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Churchappenings is a centerpiece when it comes to church management.  We incorporate just about all core aspects of church management.  The concept has evolved leaps and bounds over the past year, and we are now proud to declare that over 50 critical functions can now be managed effectively with one solution.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  "May your worship experience be enhanced by our efforts.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Mission Statement',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "Our mission is to become the solution provider that remains intimately engaged in the long-term enhancement goals of your church services.  ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Vision Statement',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "Our disruptive approach to problem solving is what drives the innovative curiosity that our team thrives on, and we invite all our users along the journey to higher heights where we redefine how expectations are set through genuine collaborative engagement at all levels within the organization. We know that old habits are hard to break, but with our laser focus on your satisfaction we will be embraced as a partner, rather than a provider in short order.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Values Statement',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "As a company, the values we share among employees include honesty, personal excellence, mutual respect, integrity and providing exceptional value.  Our commitment to our customer is grounded in the belief that we should treat others as we would like to be treated.  This propels us to honor commitments, and deadlines.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Inspired by',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "Basil and Shirley Menns.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}
