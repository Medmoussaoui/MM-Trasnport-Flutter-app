import 'dart:developer' as developer;

class CustomPrint {
  static printRedText(String text) {
    developer.log('[\x1B[31m][$text][\x1B[31m]');
  }

  static printGreenText(String text) {
    developer.log('[\x1B[32m][$text][\x1B[32m]');
  }

  static printYellowText(String text) {
    developer.log('[\x1B[33m][$text][\x1B[33m]');
  }
}
