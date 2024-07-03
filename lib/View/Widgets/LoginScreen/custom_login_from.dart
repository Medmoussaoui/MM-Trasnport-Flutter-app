import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_form_faild.dart';
import 'package:mmtransport/Functions/validation_required_form.dart';
import 'package:mmtransport/controllers/login_controller.dart';

class LoginForm extends GetView<LoginControlle> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginControlle>(
      id: "login",
      builder: (con) {
        return Opacity(
          opacity: con.loginStatus.isLoading ? 0.5 : 1.0,
          child: AbsorbPointer(
            absorbing: con.loginStatus.isLoading,
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  CustomTextFormFaild(
                    icon: Icons.account_circle_rounded,
                    controller: controller.username,
                    hintText: "اسم المستخدم",
                    validator: requiredFormValidation,
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormFaild(
                    icon: Icons.password,
                    isSecure: true,
                    controller: controller.password,
                    hintText: "كلمة السر",
                    validator: requiredFormValidation,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
