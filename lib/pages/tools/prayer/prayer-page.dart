import 'package:churchappenings/constants/red-material-color.dart';
import 'package:churchappenings/pages/tools/prayer/incoming-prayers/incomming_prayers_screen.dart';
import 'package:churchappenings/pages/tools/prayer/prayer-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../widgets/custom_button.dart';
import '../prayerometer/prayerometer-page.dart';

class PrayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PrayerContoller>(
        global: false,
        init: PrayerContoller(),
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navigateToWidget(),
                      Row(
                        children: [
                          customButton(
                            title: 'Incomming',
                            onTap: () {
                              Get.to(
                                IncommingPrayerScreen(),
                              );
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          customButton(
                            title: 'Outgoing',
                            onTap: () {
                              _.navigateToOutgoing();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _praymeter(_),

                  // SizedBox(height: 10),
                  // Text(
                  //   'Prayer Management',
                  //   style: TextStyle(
                  //     fontSize: 25,
                  //     fontWeight: FontWeight.w700,
                  //     height: 1.5,
                  //   ),
                  // ),
                  // Text(
                  //   'Church prayer request or respond to the payers',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w300,
                  //     height: 1.5,
                  //   ),
                  // ),
                  // SizedBox(height: 50),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: _.data.map<Widget>(
                  //     (e) {
                  //       return Container(
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             width: 1,
                  //             color: Colors.grey.withOpacity(0.5),
                  //           ),
                  //         ),
                  //         padding: EdgeInsets.symmetric(
                  //             vertical: 15, horizontal: 20),
                  //         margin: EdgeInsets.only(bottom: 20),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               e["title"],
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.w700,
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //             SizedBox(height: 3),
                  //             Text(
                  //               e["description"],
                  //             ),
                  //             SizedBox(height: 20),
                  //             GestureDetector(
                  //               onTap: () {
                  //                 _.openBottomShit(e["id"], context);
                  //               },
                  //               child: Text(
                  //                 'Pray',
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w700,
                  //                   color: redColor,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ).toList(),
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _praymeter(PrayerContoller _) {
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
