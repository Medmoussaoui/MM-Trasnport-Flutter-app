import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mmtransport/Functions/open_file.dart';
import 'package:share_plus/share_plus.dart';

class AppNotification {
  static Future<void> notificationPermission() async {
    final isAllow = await AwesomeNotifications().isNotificationAllowed();
    if (isAllow) return;
    await AwesomeNotifications().requestPermissionToSendNotifications();
  }

  NotificationChannel syncDataNotificationChannel() {
    return NotificationChannel(
      channelKey: 'syncData',
      channelName: 'syncData',
      channelDescription: "sync progress bar notification",
      importance: NotificationImportance.High,
      playSound: false,
      icon: "resource://drawable/mimounappicon",
    );
  }

  NotificationChannel reminderNotifications() {
    return NotificationChannel(
      icon: "resource://drawable/mimounappicon",
      channelKey: 'reminder',
      channelName: 'reminder',
      channelDescription: "for Reminder notifications",
      importance: NotificationImportance.High,
      playSound: true,
    );
  }

  List<NotificationChannel> channels() {
    return [
      syncDataNotificationChannel(),
      reminderNotifications(),
    ];
  }

  void notificationActionsLisener() {
    AwesomeNotifications().actionStream.listen((action) {
      if (action.buttonKeyPressed == "open") {
        openFilebyPath(action.payload!["path"]!);
        AwesomeNotifications().cancel(2);
      }
      if (action.buttonKeyPressed == "share") {
        Share.shareXFiles([XFile(action.payload!["path"]!)]);
        AwesomeNotifications().cancel(2);
      }
    });
  }

  Future<void> initial() async {
    await AwesomeNotifications().initialize(
      "resource://drawable/mimounappicon",
      channels(),
    );
    notificationActionsLisener();
  }
}
