import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_primary_button.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/controllers/login_controller.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginControlle controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginControlle>(
      id: "login",
      builder: (con) {
        final isLoading = con.loginStatus.isLoading;
        return Opacity(
          opacity: con.loginStatus.isLoading ? 0.5 : 1,
          child: CustomPrimaryButton(
            bottomPadding: 5.0,
            buttonText: "تسجيل الدخول",
            onPressed: controller.login,
            child: isLoading ? const CustomProgressIndicator() : null,
          ),
        );
      },
    );
  }
}
