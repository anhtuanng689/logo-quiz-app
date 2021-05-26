import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Audio {
  // static AudioCache cache = AudioCache();

  static Future<AudioPlayer> playNormalClick() async {
    AudioCache cache = AudioCache();
    return await cache.play("raw/normal_click.mp3");
  }

  static Future<AudioPlayer> playWordClick() async {
    AudioCache cache = AudioCache();
    return await cache.play("raw/click.mp3");
  }

  static Future<AudioPlayer> playCorrect() async {
    AudioCache cache = AudioCache();
    return await cache.play("raw/cr_ans.mp3");
  }

  static Future<AudioPlayer> playWrong() async {
    AudioCache cache = AudioCache();
    return await cache.play("raw/wrong.wav");
  }

  static Future<AudioPlayer> playWin() async {
    AudioCache cache = AudioCache();
    return await cache.play("raw/win.mp3");
  }
}
