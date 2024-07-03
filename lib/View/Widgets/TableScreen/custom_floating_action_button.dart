import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/TableScreen/index.dart';

class CustomTableScreenFloatingActionButton extends GetView<TableScreenController> {
  const CustomTableScreenFloatingActionButton({Key? key}) : super(key: key);

  Widget _icon(bool hasRowsSelected) {
    if (hasRowsSelected) return const Icon(Icons.more_vert_rounded);
    return const Icon(Icons.exposure_zero_rounded);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.tableDataController.selectRowsController.selectMode.value) {
        bool hasRowsSelected = controller.tableDataController.selectRowsController.totalRowsSelect >= 1;
        return FloatingActionButton(
          backgroundColor: AppColors.secondColor,
          onPressed: () {
            if (hasRowsSelected) controller.showTableSelectSheet();
          },
          child: _icon(hasRowsSelected),
        );
      }
      return FloatingActionButton(
        onPressed: () {
          controller.createService();
        },
        child: const Icon(Icons.add),
      );
    });
  }
}
