import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/class/user.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dy;
  late Animation<double> _dx;
  late Animation<double> _opacity;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    )..addListener(() {
        setState(() {});
      });
    _dy = Tween(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    )..addListener(() {
        setState(() {});
      });

    _dx = Tween(begin: -20.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    )..addListener(() {
        setState(() {});
      });

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Opacity(
          opacity: _opacity.value,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0.0, _dy.value),
                      child: Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.05, bottom: Get.height * 0.05),
                        child: Center(child: Image.asset(AppImages.driver, height: 80)),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, _dy.value),
                      child: const CustomLargeTitle(
                        title: "معلومات الحساب",
                        size: 18,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0.0, _dy.value),
                      child: const Text(
                        "معلومات الحساب الشخصي ليس لديك حق الوصول لتعديل عليها يمكنك الاتصال بالادارة اذا اردت ذالك",
                        style: TextStyle(fontSize: 15.0, color: AppColors.geyDeep),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: Get.height * 0.05),
                    Transform.translate(
                      offset: Offset(_dx.value, 0.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5.0,
                              spreadRadius: 2.5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AccountInfoItem(
                              title: "الاسم الكامل",
                              value: AppUser.user.driverName!,
                            ),
                            const Divider(height: 10),
                            AccountInfoItem(
                              title: "اسم المستخدم",
                              value: AppUser.user.username!,
                            ),
                            const Divider(height: 10),
                            const AccountInfoItem(title: "كلمة المرور", value: "*********"),
                            const Divider(height: 10),
                            AccountInfoItem(title: "تاريخ التسجيل", value: getDate(AppUser.user.registrationDate!)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.arrow_back),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AccountInfoItem extends StatelessWidget {
  final String title;
  final String value;

  const AccountInfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomLargeTitle(title: title, size: 15.0),
          Text(
            value,
            style: const TextStyle(fontSize: 14.0, color: AppColors.geyDeep),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
