import 'package:churchappenings/pages/library/songs/songs-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SongsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            navigateToWidget(),
            SizedBox(height: 10),
            Text(
              'Songs',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
            Text(
              'Listen songs',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                height: 1.5,
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GetBuilder<SongsController>(
                init: SongsController(),
                builder: (controller) {
                  return ListView.builder(
                    itemCount: controller.songs.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        leading: Image(
                          image: NetworkImage(
                            controller.songs[index].thumbnailUrl,
                          ),
                        ),
                        title: Text(controller.songs[index].title),
                        subtitle: Text(controller.songs[index].shortDesc),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
