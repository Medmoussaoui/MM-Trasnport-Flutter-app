import 'package:mmtransport/Functions/get_storage.dart';
import 'package:mmtransport/class/user.dart';

Future<String> getAccessToken() async {
  final storage = await getStorage();
  final accessToken = await storage.readString("access-token");
  AppUser.accessToken = accessToken;
  return accessToken ?? "";
}

Future<void> setAccessToken(String accessToken) async {
  final storage = await getStorage();
  await storage.setString("access-token", accessToken);
  AppUser.initial(accessToken);
}
