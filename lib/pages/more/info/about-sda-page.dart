import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';

class AboutSDAPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle paragraphStyle = TextStyle(
      fontSize: 16,
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
                  'About SDA Church',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Seventh-day Adventists believe in the perpetual development of a personal spiritual relation with God.  We believe this is enhanced through an enjoyment of His creation and the study of His Word. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  "We believe God has made us stewards of creation, and we are to care for all of it including our fellow human beings, animals, and the environment. Adventists believe that the Bible is the only rule of faith and practice for the Christian and that people of every nation, ethnicity and language are invited to follow its precepts. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  "Seventh-day Adventists unwaveringly believe in solemnity of the ten commandments, including the fourth which requires the observance of the seventh day of the week, Saturday, as the Sabbath of the Lord as declared In Exodus 20:8-11, based on Genesis 2:1-3. ",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  "Adventists believe in the sacredness of the biblical origins of the family. They have a strong sense of community, and encourage healthy living and practices recognizing that the body is the temple of the Holy Spirit. The sense of community is fostered through weekly study time for all ages known as Sabbath School and a worship service quite often followed by a healthy yet tasty meal prepared by church members.",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
                Text(
                  "For more about the Seventh-day Adventist Church, it's history, fundamental beliefs, organizational structure, etc, click here to be connected to our official website www.Adventist.org Contributed by: Pastor Delthony Gordon",
                  style: paragraphStyle,
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ));
  }
}
