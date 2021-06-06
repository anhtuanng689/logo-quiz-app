import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio {
  AudioCache cache = AudioCache();

  Future<AudioPlayer> playNormalClick() async {
    return await cache.play("raw/normal_click.mp3");
  }

  Future<AudioPlayer> playWordClick() async {
    return await cache.play("raw/click.mp3");
  }

  Future<AudioPlayer> playCorrect() async {
    return await cache.play("raw/cr_ans.mp3");
  }

  Future<AudioPlayer> playWrong() async {
    return await cache.play("raw/wrong.wav");
  }

  Future<AudioPlayer> playWin() async {
    return await cache.play("raw/win.mp3");
  }
}
