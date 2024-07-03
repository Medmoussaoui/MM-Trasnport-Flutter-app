import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/app_bar.dart';

class CustomInvoiceStoreSelectModeAppBar extends StatelessWidget {
  final ValueNotifier<bool> selectMode;
  final RxList selectList;
  final Function onClose;
  final Function onDelete;
  const CustomInvoiceStoreSelectModeAppBar({
    super.key,
    required this.selectList,
    required this.selectMode,
    required this.onClose,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      child: Row(
        children: [
          SelectModeCounter(totalSelect: selectList),
          const Spacer(),
          CustomInvoiceStoreAppBarIcon(
            icon: const Icon(Icons.delete_outline_rounded),
            ontap: onDelete,
          ),
          const SizedBox(width: 10),
          CustomInvoiceStoreAppBarIcon(
            icon: const Icon(Icons.close_rounded),
            ontap: onClose,
          ),
        ],
      ),
    );
  }
}

class SelectModeCounter extends StatelessWidget {
  final RxList totalSelect;

  const SelectModeCounter({
    super.key,
    required this.totalSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Row(
          children: [
            const Icon(Icons.layers_rounded, color: AppColors.secondColor),
            const SizedBox(width: 7.0),
            CustomLargeTitle(
              title: totalSelect.length.toString(),
              size: 18.0,
            )
          ],
        );
      },
    );
  }
}
