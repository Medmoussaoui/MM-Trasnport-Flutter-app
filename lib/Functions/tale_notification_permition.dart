import 'package:mmtransport/class/notifications.dart';

Future<void> takeNotificationPermittion() async {
  await AppNotification.notificationPermission();
}
