// import 'package:audioplayers/audioplayers.dart';
// import 'package:churchappenings/models/song.dart';
// import 'package:get/get.dart';

// class PlaySongController extends GetxController {
//   final SongModel song;
//   PlaySongController({required this.song});

//   bool isPlaying = false;
//   Duration totalDuration = Duration();
//   Duration position = Duration();

//   AudioPlayer audioPlayer = AudioPlayer();

//   @override
//   void onReady() {
//     playAudio();
//     pauseAudio();
//     audioPlayer.onDurationChanged.listen((updatedDuration) {
//       totalDuration = updatedDuration;
//       update();
//     });

//     audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
//       position = updatedPosition;
//       update();
//     });

//     super.onReady();
//   }

//   playAudio() {
//     audioPlayer.play(song.fileUrl);
//     isPlaying = true;
//     update();
//   }

//   pauseAudio() {
//     audioPlayer.pause();
//     isPlaying = false;
//     update();
//   }

//   stopAudio() {
//     audioPlayer.stop();
//   }

//   seekAudio(Duration durationToSeek) {
//     audioPlayer.seek(durationToSeek);
//   }

//   @override
//   void onClose() {
//     audioPlayer.dispose();
//     super.onClose();
//   }
// }
