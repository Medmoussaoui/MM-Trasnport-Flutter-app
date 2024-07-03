import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_container.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_primary_button.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Components/custom_secondry_button.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/View/Widgets/CreateService/create_service_form.dart';
import 'package:mmtransport/View/Widgets/CreateService/custom_note_form.dart';
import 'package:mmtransport/View/Widgets/CreateService/select_service_status.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mmtransport/controllers/EditService/index.dart';

class EditServiceScreen extends StatelessWidget {
  const EditServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditServiceScreenController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        title: const CustomLargeTitle(
          title: "تعديل الخدمة",
        ),
      ),
      bottomNavigationBar: CustomEditServiceBottomBotton(controller: controller),
      body: Obx(
        () {
          return Opacity(
            opacity: controller.onSaving.value ? 0.5 : 1.0,
            child: AbsorbPointer(
              absorbing: controller.onSaving.value,
              child: Padding(
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
                          const SizedBox(height: 25),
                          CustomServiceStatus(
                            groupValue: controller.serviceStatus,
                            onChange: (value) {
                              controller.serviceStatus.value = value;
                            },
                          ),
                          const SizedBox(height: 25),
                          CustomCreateServiceNoteForm(
                            noteFormController: controller.noteFormController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomEditServiceBottomBotton extends StatelessWidget {
  const CustomEditServiceBottomBotton({
    super.key,
    required this.controller,
  });

  final EditServiceScreenController controller;

  Widget? _saveButtonChild(bool isSaving) {
    if (isSaving) {
      return const CustomProgressIndicator();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        if (isKeyboardVisible) return const SizedBox.shrink();
        return Obx(
          () {
            return Opacity(
              opacity: controller.onSaving.value ? 0.5 : 1.0,
              child: CustomAnimatedBottomContainer(
                color: AppColors.black,
                visible: ValueNotifier(true),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: AbsorbPointer(
                        absorbing: controller.onSaving.value,
                        child: CustomSecondaryyButton(
                          title: "تحديد الشاحنة",
                          icon: Icons.qr_code_scanner_outlined,
                          textColor: AppColors.secondColor.withOpacity(0.9),
                          elevation: 0,
                          borderColor: AppColors.secondColor,
                          color: AppColors.black,
                          bottomPadding: 0,
                          topPadding: 0,
                          onPressed: () {
                            controller.selectTruckNumber();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomPrimaryButton(
                        elevation: 1,
                        bottomPadding: 0,
                        topPadding: 0,
                        buttonText: "حفض",
                        onPressed: () {
                          controller.saveServiceButton();
                        },
                        child: _saveButtonChild(controller.onSaving.value),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
