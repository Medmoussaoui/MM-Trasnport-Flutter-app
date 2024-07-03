import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.routes.dart';
import 'package:mmtransport/class/user.dart';

class LoginMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AppUser.accessToken == null) return null;
    return const RouteSettings(name: AppRoutes.home);
  }
}
