import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
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
                  'Terms of Service',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Usage Expectations',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "I understand that Churchappenings is a platform designed to enhance church attendees worship experience and should only be used for such purposes.  While there are some non-church functions available, the objective is to bolster a religious experience where like minded users can collaborate on all levels presented in this platform.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Location and Notification Alert',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "Our location services are designed to enhance your user experience and I (the application user),  agree to receive location related info generated as a result of the location service being enabled by me, the user. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Push Notifications',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "I accept the push notifications generated within the app, and understand that the notifications that are not disabled by me will be provided. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Personal Information',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "I understand that the personal information I provide may be usable by churchappenings only to enhance my user experience, and may be available for other members to view, such as ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "- My profile information",
                  style: paragraphStyle,
                ),
                Text(
                  "- Employment status",
                  style: paragraphStyle,
                ),
                Text(
                  "- Country of residence",
                  style: paragraphStyle,
                ),
                Text(
                  "- Baptism status",
                  style: paragraphStyle,
                ),
                Text(
                  "- Membership affiliation, unless suppressed by user.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Issue Resolution Expectations',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "It is our goal at churchappenings to have a flawlessly operational system, and we will work consistently to accomplish this goal. While true, we understand that you will have questions, and our goal is to respond to all concerns within 48 hours. Please submit concerns through the help menu.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Payment Clause',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "Payment for our services will be thorough our embedded payment gateway which is subject to change without notice, and will be sent directly to churchappenings, or the parent company.  All sums pursuant to this agreement are due prior to the beginning of the users second month of service. Any query concerning the agreement or the charges made shall not affect the Client’s obligation to pay all outstanding balances immediately.  Thumbs up Group reserves the right to disable services with no additional notice  that stated here for future services.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Credit Card Payments',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "In the event of a breach of security, you will remain liable for any unauthorized use of your credit card until you update your information.\nYou are entirely responsible for any and all activities which occur under your user account.\nYou represent and warrant that if you are making online payments that:",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "- Any credit card, debit card and bank account information you supply is true, correct and complete",
                  style: paragraphStyle,
                ),
                Text(
                  "- Charges incurred by you will be honored by your credit/debit card company or bank",
                  style: paragraphStyle,
                ),
                Text(
                  "- You will pay the charges incurred by you in the amounts posted, including any applicable taxes/fees",
                  style: paragraphStyle,
                ),
                Text(
                  "- You are the person in whose name the card was issued and you are authorized to make a purchase or other transaction with the relevant credit card and credit card information.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}
