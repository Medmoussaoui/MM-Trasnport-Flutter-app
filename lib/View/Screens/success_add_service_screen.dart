import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/View/Widgets/SuccessAddService/ticket_service.dart';
import 'package:mmtransport/controllers/success_create_service.dart';

class SuccessAddServiceScreen extends StatelessWidget {
  const SuccessAddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuccessCreateServiceController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.success, height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CustomLargeTitle(title: "تم اضافة الخدمة بنجاح", size: 16.5),
                  ),
                  CustomTicketService(service: controller.service),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: IconButton(
                    splashRadius: 24.0,
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
