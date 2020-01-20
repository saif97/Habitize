import 'package:audioplayers/audio_cache.dart';

class AudioUtils {
  AudioCache audioPlayer = AudioCache();

  playSoundAllChecked() => audioPlayer.play("check.mp3");

  playSoundIterationChecked() => audioPlayer.play("iteration_check.mp3");
}
