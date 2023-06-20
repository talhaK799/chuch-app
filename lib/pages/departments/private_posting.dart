import 'package:flutter/material.dart';

import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';

class PrivatePosting extends StatelessWidget {
  const PrivatePosting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                navigateToWidget(),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Private Posting",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
