import 'package:churchappenings/pages/tools/prayerometer/prayerometer-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
                    ],
                  ),
                  SizedBox(height: 10),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
