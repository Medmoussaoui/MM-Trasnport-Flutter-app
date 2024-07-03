import 'package:mmtransport/class/sounds.dart';
import 'package:vibration/vibration.dart';

Future<void> barcodeScannerSound() async {
  AppAudio.scanCode();
  Vibration.vibrate(duration: 200);
  return;
}
