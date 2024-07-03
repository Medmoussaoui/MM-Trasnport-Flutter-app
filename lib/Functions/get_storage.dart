import 'package:mmtransport/class/local_storage.dart';

Future<LocalStorage> getStorage() async {
  return await LocalStorage.instance;
}
