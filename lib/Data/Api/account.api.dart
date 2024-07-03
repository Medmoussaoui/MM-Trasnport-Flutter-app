import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.api.dart';
import 'package:mmtransport/Functions/handling_api_responce.dart';
import 'package:mmtransport/class/api_connection.dart';

class AccountApi extends GetConnect {
  Future<StatusRequest> login(String username, String password) async {
    final res = await post(AppApiLinks.account.login, {
      "username": username,
      "password": password,
    });
    return handleApiResponce(res);
  }

  Future<StatusRequest> changePassword(String currentPassword, String newPassword) async {
    final res = await post(
      AppApiLinks.account.changePassword,
      {currentPassword, newPassword},
    );
    return handleApiResponce(res);
  }
}
