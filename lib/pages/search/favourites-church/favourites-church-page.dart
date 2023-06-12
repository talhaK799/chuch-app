import 'package:churchappenings/widgets/navigate-back-widget.dart';

import 'build-churches-card.dart';
import 'favourites-church-controller.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesChurchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            navigateToWidget(),
            SizedBox(height: 10),
            Text(
              'Favorites',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
            Text(
              'You can mark churches as favourites',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                height: 1.5,
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: GetBuilder<FavouritesChurchController>(
                init: FavouritesChurchController(),
                builder: (controller) => ListView.builder(
                    itemCount: controller.churches.length,
                    itemBuilder: (context, index) {
                      return buildChurchCard(controller.churches[index]);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
