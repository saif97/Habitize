

import 'package:audioplayers/audioplayers.dart';

class AudioUtils {
  AudioCache audioPlayer = AudioCache();

  Future playSoundAllChecked() => audioPlayer.play("check.mp3", isNotification: true);

  Future playSoundIterationChecked() => audioPlayer.play("iteration_check.mp3", isNotification: true);
}

