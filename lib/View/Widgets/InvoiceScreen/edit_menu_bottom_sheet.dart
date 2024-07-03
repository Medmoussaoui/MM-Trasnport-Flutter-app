import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_item.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/InvoiceScreen/index.dart';

class InvoiceEditBottomSheet extends GetView<InvoiceScreenController> {
  const InvoiceEditBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
      decoration: const BoxDecoration(
        color: AppColors.bottomSheetColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomBottomSheetSlider(),
          const SizedBox(height: 15),
          CustomBottomSheetItem(
            icon: Icons.edit_document,
            title: "تعديل بيانات الجدول",
            onTap: () => controller.editInvoiceTable(),
          ),
          CustomBottomSheetItem(
            icon: Icons.edit_outlined,
            title: "تغير اسم الفاتورة",
            onTap: () {
              controller.changeInvoiceName();
            },
          ),
        ],
      ),
    );
  }
}
