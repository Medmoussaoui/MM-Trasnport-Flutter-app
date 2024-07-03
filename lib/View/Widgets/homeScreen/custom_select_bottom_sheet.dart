import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_item.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/HomePage/index.dart';

class CustomHomeScreenSelectBottomSheet extends GetView<HomePageController> {
  const CustomHomeScreenSelectBottomSheet({Key? key}) : super(key: key);

  Widget _editRow() {
    if (controller.tableDataController.selectRowsController.totalRowsSelect.value == 1) {
      return CustomBottomSheetItem(
        icon: Icons.edit,
        title: "تعديل البانات",
        onTap: () async {
          Get.back();
          await Future.delayed(const Duration(milliseconds: 200));
          controller.editRow();
        },
      );
    }
    return const SizedBox.shrink();
  }

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
          CustomBottomSheetItem(
            icon: Icons.drive_folder_upload,
            title: "نقل العناصر",
            onTap: () {},
          ),
          _editRow(),
          CustomBottomSheetItem(
            icon: Icons.delete_outlined,
            title: "مسح العناصر",
            color: Colors.red,
            onTap: () {
              Get.back();
              controller.removeSelectRows();
            },
          ),
        ],
      ),
    );
  }
}
