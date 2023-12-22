import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/prayerometer/prayerometer-controller.dart';
import 'package:churchappenings/pages/tools/prayerometer/requests/request_screen.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../widgets/custom_button.dart';
import '../../../widgets/white_button.dart';

class PrayeroMeterPage extends StatelessWidget {
  const PrayeroMeterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PrayerometerController>(
        init: PrayerometerController(),
        global: false,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    navigateToWidget(),
                    // customButton(
                    //     title: 'My Requests',
                    //     onTap: () {
                    //       Get.to(RequestScreen());
                    //     }),
                  ],
                ),
                SizedBox(height: 20),
                _praymeter(_)
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     customWhiteButton(
                //         title: 'All Requests',
                //         isActive: _.isall,
                //         onTap: () {
                //           _.changeTab(true);
                //         }),
                //     // SizedBox(
                //     //   width: 10,
                //     // ),
                //     customWhiteButton(
                //         title: 'Prayometer',
                //         isActive: _.isPray,
                //         onTap: () {
                //           _.changeTab(false);
                //         }),
                //   ],
                // ),
                // SizedBox(height: 10),
                // _.isPray.value == true
                // ?

                // : Expanded(
                //     child: ListView.separated(
                //       shrinkWrap: true,
                //       // primary: false,
                //       itemCount: 3,
                //       itemBuilder: (context, index) =>
                //           _postSection(context, _),
                //       separatorBuilder: (context, index) => SizedBox(
                //         height: 15,
                //       ),
                //     ),
                //   )
              ],
            ),
          );
        },
      ),
    );
  }

  // _postSection(context, _) {
  //   return Container(
  //     padding: EdgeInsets.only(
  //       left: 16,
  //       right: 16,
  //       bottom: 5,
  //       top: 16,
  //     ),
  //     decoration: BoxDecoration(
  //         color: greyColor, borderRadius: BorderRadius.circular(12)),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             CircleAvatar(
  //               // You can replace the image with the user's profile picture
  //               backgroundImage: AssetImage('assets/placeholder-1000.png'),
  //               radius: 30.0,
  //             ),
  //             SizedBox(width: 16.0),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'John Doe',
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 18.0,
  //                   ),
  //                 ),
  //                 Text('@johndoe'),
  //               ],
  //             ),
  //           ],
  //         ),
  //         Container(
  //           padding: EdgeInsets.all(20.0),
  //           child: Text(
  //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  //             style: TextStyle(fontSize: 16.0),
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.all(16.0),
  //           child: ElevatedButton(
  //             onPressed: () {
  //               showModalBottomSheet(
  //                 context: context,
  //                 useSafeArea: true,
  //                 // isScrollControlled: true,

  //                 enableDrag: true,
  //                 builder: (context) {
  //                   return CommentBox(
  //                     userImage: AssetImage('assets/placeholder-1000.png'),
  //                     child: commentChild(_),
  //                     labelText: 'Write a comment...',
  //                     errorText: 'Comment cannot be blank',
  //                     withBorder: false,
  //                     sendButtonMethod: () {
  //                       if (_.formKey.currentState!.validate()) {
  //                         print(_.commentController.text);
  //                         // setState(() {
  //                         //   var value = {
  //                         //     'name': 'New User',
  //                         //     'pic':
  //                         //         'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
  //                         //     'message': commentController.text,
  //                         //     'date': '2021-01-01 12:00:00'
  //                         //   };
  //                         //   filedata.insert(0, value);
  //                         // });
  //                         _.commentController.clear();
  //                         FocusScope.of(context).unfocus();
  //                       } else {
  //                         print("Not validated");
  //                       }
  //                     },
  //                     formKey: _.formKey,
  //                     commentController: _.commentController,
  //                     backgroundColor: redColor,
  //                     textColor: Colors.white,
  //                     sendWidget:
  //                         Icon(Icons.send_sharp, size: 30, color: Colors.white),
  //                   );
  //                 },
  //               );
  //             },
  //             child: Text('Comments'),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  commentChild(PrayerometerController _) {
    return ListView.builder(
      itemCount: _.filedata.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                // Display the image in large form.
                print("Comment Clicked");
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: new BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: CommentBox.commentImageParser(
                    imageURLorPath: _.filedata[index].userImage,
                  ),
                ),
              ),
            ),
            title: Text(
              _.filedata[index].userName ?? "user",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_.filedata[index].message ?? ""),
            trailing: Text(_.filedata[index].date ?? '00-00',
                style: TextStyle(fontSize: 10)),
          ),
        );
      },
    );
  }

  _praymeter(PrayerometerController _) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prayer Meter',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            height: 1.5,
          ),
        ),
        Text(
          'Church prayer meter',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            height: 1.5,
          ),
        ),
        SizedBox(height: 100),
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 100,
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 33,
                  color: Colors.red,
                ),
                GaugeRange(
                  startValue: 33,
                  endValue: 66,
                  color: Colors.orange,
                ),
                GaugeRange(
                  startValue: 66,
                  endValue: 100,
                  color: Colors.green,
                ),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(value: _.score),
                MarkerPointer(value: _.score)
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                  widget: Container(
                    child: Text(
                      _.score.toString() + ' %',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  angle: 90,
                  positionFactor: 0.5,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
