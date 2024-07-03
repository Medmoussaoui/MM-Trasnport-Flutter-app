import 'package:audioplayers/audioplayers.dart';
import 'package:mmtransport/Constant/app.sounds.dart';

class AppAudio {
  static late AudioCache audioCash;

  static initial() {
    AppAudio.audioCash = AudioCache(prefix: AppSounds.filePath);
  }

  static paySuccess() async {
    await AppAudio.audioCash.play(AppSounds.paySuccess);
  }

  static scanCode() async {
    await AppAudio.audioCash.play(AppSounds.scanCode);
  }
}
