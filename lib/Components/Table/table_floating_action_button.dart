import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Constant/app.color.dart';

class TableFloatingActionButton extends StatelessWidget {
  final TableDataController controller;

  const TableFloatingActionButton({
    Key? key,
    required this.onPressToAdd,
    required this.onPressWithSelectMode,
    required this.controller,
  }) : super(key: key);

  final Function onPressWithSelectMode;
  final Function onPressToAdd;

  Widget _icon(bool hasRowsSelected) {
    if (hasRowsSelected) return const Icon(Icons.more_vert_rounded);
    return const Icon(Icons.exposure_zero_rounded);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectRowsController.selectMode.value) {
        bool hasRowsSelected = controller.selectRowsController.totalRowsSelect.value >= 1;
        return FloatingActionButton(
          backgroundColor: AppColors.secondColor,
          onPressed: () {
            if (hasRowsSelected) onPressWithSelectMode();
          },
          child: _icon(hasRowsSelected),
        );
      }
      return FloatingActionButton(
        onPressed: () => onPressToAdd(),
        child: const Icon(Icons.add),
      );
    });
  }
}
