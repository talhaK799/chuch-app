import 'package:churchappenings/models/song.dart';
import 'package:get/get.dart';

class SongsController extends GetxController {
  List<SongModel> songs = [
    SongModel(
      id: '1',
      thumbnailUrl:
          'https://i.pinimg.com/originals/05/58/0d/05580da0e46654e2e8d98b766878e849.jpg',
      fileUrl: 'https://d35ottccmnskmu.cloudfront.net/songs/sample3.mp3',
      title: 'Sample Song',
      shortDesc: 'Lorem ipsum dolor dummit',
    )
  ];

  // navigateToPlayScreen(SongModel song) {
  //   Routes.sailor.navigate(Routes.playSong, params: {
  //     'song': song,
  //   });
  // }
}
