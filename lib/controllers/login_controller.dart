import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_attention_dialog.dart';
import 'package:mmtransport/Constant/app.routes.dart';
import 'package:mmtransport/Data/api/account.api.dart';
import 'package:mmtransport/Functions/access_token.dart';
import 'package:mmtransport/class/api_connection.dart';

class LoginControlle extends GetxController {
  late final AccountApi api;
  late final TextEditingController password;
  late final TextEditingController username;
  late final GlobalKey<FormState> formKey;
  late StatusRequest loginStatus = StatusRequest();

  bool validateFormData() {
    bool validFormData = formKey.currentState!.validate();
    if (!validFormData) {
      // to active auto validation
      formKey.currentState!.save();
      return false;
    }
    return true;
  }

  login() async {
    if (!validateFormData() || loginStatus.isLoading) return;
    loginStatus.loading();
    update(["login"]);
    await Future.delayed(const Duration(seconds: 3));
    loginStatus = await api.login(username.text, password.text);
    update(["login"]);
    handleLoginStatus();
  }

  handleLoginStatus() async {
    if (loginStatus.isSuccess) {
      final accessToken = loginStatus.headers!["access-token"];
      await setAccessToken(accessToken!);
      return redirectToHomeScreen();
    }
    customAttentionDialogSheet(
      title: "فشل تسجيل الدخول",
      subTitle: "اسم المستخدم أو كلمة المرور الخاصة بك غير صالحة حاول مرة اخرى",
    );
  }

  void redirectToHomeScreen() {
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onInit() {
    api = AccountApi();
    password = TextEditingController();
    username = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.onInit();
  }

  @override
  void onClose() {
    password.dispose();
    username.dispose();
    super.dispose();
  }
}
