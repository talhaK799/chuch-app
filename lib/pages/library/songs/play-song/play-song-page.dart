// import 'package:churchappenings/models/song.dart';
// import 'package:churchappenings/pages/library/songs/play-song/play-song-controller.dart';
// import 'package:churchappenings/widgets/navigate-back-widget.dart';
// import 'package:churchappenings/widgets/transparentAppbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class PlaySongPage extends StatelessWidget {
//   final SongModel song;
//   PlaySongPage({required this.song});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: transparentAppbar(),
//       body: GetBuilder<PlaySongController>(
//         init: PlaySongController(song: song),
//         builder: (controller) {
//           return Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     navigateToWidget(),
//                   ],
//                 ),
//                 SizedBox(height: 30),
//                 Center(
//                   child: Container(
//                     width: 250,
//                     height: 250,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: NetworkImage(song.thumbnailUrl),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.circular(200)),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   song.title,
//                   style: TextStyle(fontSize: 25),
//                 ),
//                 Text(
//                   song.shortDesc,
//                   style: TextStyle(
//                       fontSize: 17, color: Colors.black.withOpacity(0.5)),
//                 ),
//                 SizedBox(height: 40),
//                 SliderTheme(
//                   data: SliderThemeData(
//                     trackHeight: 5,
//                     thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5),
//                   ),
//                   child: Slider(
//                     value: controller.position.inMilliseconds.toDouble(),
//                     min: 0,
//                     max: controller.totalDuration.inMilliseconds.toDouble(),
//                     onChanged: (newPosition) {
//                       controller.seekAudio(
//                         Duration(
//                           milliseconds: newPosition.toInt(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(controller.position.toString().split(".").first),
//                       Text(
//                           controller.totalDuration.toString().split(".").first),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 GestureDetector(
//                   onTap: () {
//                     controller.isPlaying
//                         ? controller.pauseAudio()
//                         : controller.playAudio();
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(30),
//                     decoration: BoxDecoration(
//                       color: redColor,
//                       borderRadius: BorderRadius.circular(100),
//                     ),
//                     child: Icon(
//                       controller.isPlaying ? Icons.pause : Icons.play_arrow,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
