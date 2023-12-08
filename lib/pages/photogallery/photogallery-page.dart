import 'package:churchappenings/pages/photogallery/photogallery-controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:churchappenings/widgets/transparentAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class PhotoGalleryPage extends StatelessWidget {
  const PhotoGalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppbar(),
      body: GetBuilder<PhotoGalleryController>(
        init: PhotoGalleryController(),
        global: true,
        builder: (_) {
          if (_.loading) {
            return Center(child: CircularProgressIndicator());
          }

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
                      // GestureDetector(
                      //   child: Text(
                      //     'Create',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w700,
                      //       color: redColor,
                      //       fontSize: 17,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Photo Gallery',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    'View photos uploaded in church',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _.searchQueryController,
                      decoration: InputDecoration(
                        hintText: 'Search by name',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            _.searchImages(_.searchQueryController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  MasonryGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    shrinkWrap: true,
                    itemCount: _.isSearching == true
                        ? _.searchedPhotos.length
                        : _.photos.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _.isSearching
                                ? NetworkImage(
                                    _.searchedPhotos[index].image_uri ?? '')
                                : NetworkImage(_.photos[index].image_uri ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text(
                          _.isSearching
                              ? _.searchedPhotos[index].title ?? ''
                              : _.photos[index].title ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      );
                    },
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
