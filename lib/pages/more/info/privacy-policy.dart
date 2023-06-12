import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
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
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'What Personal Data Do We Collect?',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "We may collect Biometric info for secure access to your data. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "- Name",
                  style: paragraphStyle,
                ),
                Text(
                  "- Address",
                  style: paragraphStyle,
                ),
                Text(
                  "- Picture",
                  style: paragraphStyle,
                ),
                Text(
                  "- Employment status",
                  style: paragraphStyle,
                ),
                Text(
                  "- Location info",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "Though we collect the information, Its use is it enhance user experience. Only, however most of the information can be made private, or is optionally collected.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'My Personal Data',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "All users have the ability to modify their posted information at will from the settings menu. If you have any questions, our dynamic Faq is a valuable resource.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Global Considerations',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "We currently operate in a global space.  There are no regional limitations for our platform.  You have needs, and we have developed a solution for you.  Please ensure that you do not violate any local laws while using our platform.  We hope you enjoy. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Storage and Security',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "We follow generally accepted standards to protect the personal data we receive.   Any payment transactions are encrypted with the latest standards to reduce the likelihood of any data breaches.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "We retain personal data to the extent necessary to provide needed services to our customers. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'User Rights',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "You may have the right to:",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "- Request access to details of the personal data held by us about you, free of charge;",
                  style: paragraphStyle,
                ),
                Text(
                  "- Request the restricted use or erasure of your personal data held by us;",
                  style: paragraphStyle,
                ),
                Text(
                  "- to request that any personal data provided by you, be transferred to a third party.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Request of Information Declaration',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "You may request information on ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "- The categories of personal information we collected about you.",
                  style: paragraphStyle,
                ),
                Text(
                  "- Our purpose for collecting personal information.",
                  style: paragraphStyle,
                ),
                Text(
                  "- The categories of third parties with whom we share personal information (where applicable)",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Profile Deletion Process',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "You may delete your profile at will where we are not legally bound to retain the information due to any potential legal proceedings.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Discrimination Policy',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "We will not discriminate against any entity that is in compliance with our usage policy.  Any violation can have you banned from the platform.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "Some examples that could get you banned.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 10),
                Text(
                  "- Falsely registering for illegitimate purpose (other than for church management)",
                  style: paragraphStyle,
                ),
                Text(
                  "- Using obscene language when communicating on the platform.",
                  style: paragraphStyle,
                ),
                Text(
                  "- Stalking members based on acquired information",
                  style: paragraphStyle,
                ),
                Text(
                  "- Hacking",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Data Integrity',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "Though we would love to share information to anyone that would like to use our platform, Data integrity is of utmost importance. As a result, there are limitations to each user that is operating in a guest capacity. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'To Our Employees or Contractors',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "This Privacy Statement does not apply to you.  Please contact your HR representative to gain clarification on any concerns you may have. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  'Changes To Our Privacy Statement',
                  style: header,
                ),
                SizedBox(height: 10),
                Text(
                  "This document may be modified at will, but all updated versions will be immediately available to all.  We encourage our users to stay informed by periodically reviewing the document to remain knowledgeable regarding our policies. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}
