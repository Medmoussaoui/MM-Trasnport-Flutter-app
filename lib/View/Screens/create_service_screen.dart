import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_container.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_secondry_button.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/View/Widgets/CreateService/create_service_form.dart';
import 'package:mmtransport/View/Widgets/CreateService/custom_note_form.dart';
import 'package:mmtransport/View/Widgets/CreateService/select_service_status.dart';
import 'package:mmtransport/controllers/CreateService/index.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class CreateServiceScreen extends StatelessWidget {
  const CreateServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateServiceController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: CustomLargeTitle(title: controller.appBarTitle),
      ),
      bottomNavigationBar: CustomCreateServiceButton(controller: controller),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Form(
              key: controller.formStateKey,
              child: Column(
                children: [
                  CustomCreateServiceForm(
                    boatNameController: controller.boatNameForm,
                    serviceTypeController: controller.serviceTypeForm,
                    priceFormController: controller.priceFormController,
                    initialDate: controller.dateTime,
                    saveDatePicker: controller.saveDatePicker,
                  ),
                  const SizedBox(height: 20),
                  CustomServiceStatus(
                    groupValue: controller.serviceStatus,
                    onChange: (value) {
                      controller.serviceStatus.value = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomCreateServiceNoteForm(
                    noteFormController: controller.noteFormController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCreateServiceButton extends StatelessWidget {
  const CustomCreateServiceButton({
    super.key,
    required this.controller,
  });

  final CreateServiceController controller;

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) return const SizedBox.shrink();
        return CustomAnimatedBottomContainer(
          color: AppColors.black,
          visible: ValueNotifier(true),
          child: CustomSecondaryyButton(
            topPadding: 0,
            bottomPadding: 0,
            title: "اضافة خدمة",
            icon: Icons.add,
            onPressed: () {
              controller.addServiceButton();
            },
          ),
        );
      },
    );
  }
}
