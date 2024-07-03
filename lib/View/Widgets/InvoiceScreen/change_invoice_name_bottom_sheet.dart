import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';
import 'package:mmtransport/Components/custom_form_faild.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_primary_button.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/InvoiceScreen/change_invoice_name_controller.dart';

class ChangeInvoieNameBottomSheet extends StatelessWidget {
  final ChangeInvoiceNameController controller;

  const ChangeInvoieNameBottomSheet({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.request,
      builder: (_, val, child) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: AbsorbPointer(
                  absorbing: controller.request.value.isLoading,
                  child: Opacity(
                    opacity: controller.request.value.isLoading ? 0.5 : 1.0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Align(alignment: Alignment.center, child: CustomBottomSheetSlider()),
                        const SizedBox(height: 10),
                        const CustomLargeTitle(title: "تعديل اسم الفاتورة"),
                        const Text(
                          "قم بتغير اسم الفاتورة وضغط على المتابعة",
                          style: TextStyle(fontSize: 15.0, color: AppColors.geyDeep),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CustomTextFormFaild(
                            controller: controller.formController,
                            autofocus: true,
                            textAlign: TextAlign.end,
                            hintText: "قم بادخال اسم للفتورة",
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomPrimaryButton(
                          buttonText: "المتابعة",
                          onPressed: () => controller.change(),
                          child: controller.request.value.isLoading ? const CustomProgressIndicator() : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  splashRadius: 23,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: AppColors.geyDeep,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
