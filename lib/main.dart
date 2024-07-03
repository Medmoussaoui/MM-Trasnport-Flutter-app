import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.routes.dart';
import 'package:mmtransport/Constant/app.them.dart';
import 'package:mmtransport/Functions/tale_notification_permition.dart';
import 'package:mmtransport/Services/index.dart';
import 'package:mmtransport/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    takeNotificationPermittion();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.primaryTheme,
      locale: const Locale("en"),
      initialRoute: AppRoutes.login,
      getPages: routes,
    );
  }
}
