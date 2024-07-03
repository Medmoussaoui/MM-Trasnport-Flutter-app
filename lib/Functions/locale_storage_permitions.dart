import 'package:permission_handler/permission_handler.dart';

Future<bool> permitionToAccessLocalStorage() async {
  bool storage = await Permission.storage.isGranted;
  bool mediaLocation = await Permission.accessMediaLocation.isGranted;
  bool manageExtenalStorage = await Permission.manageExternalStorage.isGranted;
  if (!manageExtenalStorage) await Permission.manageExternalStorage.request();
  if (!storage) storage = await Permission.storage.request().isGranted;
  if (!mediaLocation) mediaLocation = await Permission.accessMediaLocation.request().isGranted;
  return storage && mediaLocation;
}
