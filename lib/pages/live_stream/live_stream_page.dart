import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/red-material-color.dart';
import '../../widgets/navigate-back-widget.dart';
import '../../widgets/transparentAppbar.dart';
import 'live_stream_controller.dart';

class LiveStreamPage extends StatelessWidget {
  const LiveStreamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<LiveStreamController>(
        init: LiveStreamController(),
        global: false,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                navigateToWidget(),
                SizedBox(height: 10),
                Text(
                  'Live Stream Links',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: _.links.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _.links[index],
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // _.selectedCurch == _.memberFacility[index].name
                        //     ? Container()
                        // :
                        GestureDetector(
                          onTap: () {
                            // _.visitChurch(index);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Visit',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                                color: redColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
