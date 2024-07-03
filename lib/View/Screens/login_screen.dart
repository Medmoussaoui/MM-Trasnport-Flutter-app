import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/View/Widgets/LoginScreen/custom_driver_picture.dart';
import 'package:mmtransport/View/Widgets/LoginScreen/custom_login_button.dart';
import 'package:mmtransport/View/Widgets/LoginScreen/custom_login_from.dart';
import 'package:mmtransport/View/Widgets/LoginScreen/custom_need_help_button.dart';
import 'package:mmtransport/controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginControlle());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: Get.height * 0.45,
                child: Column(
                  children: const [
                    Spacer(),
                    CustomLargeTitle(title: "مرحبا بعودتك"),
                    Spacer(),
                    DriverPicture(),
                    Spacer(flex: 2),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.5,
                child: Column(
                  children: [
                    const LoginForm(),
                    const Spacer(),
                    CustomLoginButton(controller: controller),
                    const CustomLoginNeedHelpButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
