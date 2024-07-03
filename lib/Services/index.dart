import 'package:get/get.dart';
import 'package:mmtransport/Functions/access_token.dart';
import 'package:mmtransport/class/local_storage.dart';
import 'package:mmtransport/class/notifications.dart';
import 'package:mmtransport/class/sounds.dart';
import 'package:mmtransport/class/user.dart';
import 'package:mmtransport/syncData/lisener.dart';

class MyServices extends GetxService {
  Future<MyServices> init() async {
    await LocalStorage.instance;
    await AppNotification().initial();
    AppAudio.initial();
    // await initialWorkManager();
    String? accessToekn = await getAccessToken();
    AppUser.initial(accessToekn);
    return this;
  }
}

Future<void> initialServices() async {
  await Get.putAsync(() => MyServices().init());
  Get.put(SyncDataContainerLisener());
}
