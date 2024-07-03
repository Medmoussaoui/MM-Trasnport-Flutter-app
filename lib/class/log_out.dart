import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/custom_confirm_dialog.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Functions/check_internet_access.dart';
import 'package:mmtransport/class/local_storage.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/class/user.dart';

class AppLogOut {
  Future<bool> confirmLogOut() async {
    bool out = false;
    await customConfirmDialog(
      icon: Icons.logout_outlined,
      color: AppColors.primaryColor,
      title: "تسجيل الخروج",
      subTitle: "اذا كنت متاكد من عملية الخروج قم بالضغط على نعم",
      confirmTitle: "نعم",
      cancelTitle: "لا",
      confirmButtonColor: AppColors.secondColor,
      onAccept: () {
        out = true;
        Get.back();
      },
    );
    return out;
  }

  Future<void> _clearUserCredentials() async {
    final store = await LocalStorage.instance;
    await store.delete("access-token");
    AppUser.clear();
  }

  Future<void> logout() async {
    bool out = await confirmLogOut();
    if (!out) return;
    customLoadingDailog(text: "المرجو الانتضار");
    bool hasInternet = await checkInternetAccess();
    if (!hasInternet) {
      Get.back();
      return AppSnackBars.noInternetAccess();
    }
    await _clearUserCredentials();
    Get.back();
    RedirectTo.login(action: RedirectAction.offAll);
  }
}
