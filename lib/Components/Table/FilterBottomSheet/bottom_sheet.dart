import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/Table/FilterBottomSheet/filter_values_list.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';

class TableFilterBottomSheet extends StatefulWidget {
  final TableDataController controller;
  const TableFilterBottomSheet({Key? key, required this.controller}) : super(key: key);

  @override
  State<TableFilterBottomSheet> createState() => _TableFilterBottomSheetState();
}

class _TableFilterBottomSheetState extends State<TableFilterBottomSheet> {
  TextButton _selectAllButton() {
    return TextButton(
      onPressed: () {
        widget.controller.filterController.selectAllValues();
        setState(() {});
      },
      child: const Text(
        'تحديد الكل',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.therdColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  TextButton _unSelectAllButton() {
    return TextButton(
      onPressed: () {
        widget.controller.filterController.unSelectAll();
        setState(() {});
      },
      child: const Text(
        'الغاء الكل',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.geyDeep,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  String _columnName() {
    int index = widget.controller.filterController.currentColumn.columnIndex;
    return widget.controller.tableColumns[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 2,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectAllButton(),
                _unSelectAllButton(),
                const Spacer(),
                CustomLargeTitle(
                  title: _columnName(),
                  color: AppColors.secondColor,
                  size: 18,
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            color: AppColors.geyDeep.withOpacity(0.3),
          ),
          Flexible(
            child: FilterValuesListBuilder(
              controller: widget.controller.filterController,
            ),
          ),
        ],
      ),
    );
  }
}
