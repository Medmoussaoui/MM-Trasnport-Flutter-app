import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasInternet() async {
  final connection = await Connectivity().checkConnectivity();
  bool wifiConnect = connection == ConnectivityResult.wifi;
  bool mobileDataConnect = connection == ConnectivityResult.mobile;
  return wifiConnect || mobileDataConnect;
}
