import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_item.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';
import 'package:mmtransport/Constant/app.color.dart';

class TableMenuBottmSheet extends StatelessWidget {
  final void Function()? onDelete;
  final void Function()? onRename;
  final void Function()? onNewInvoice;
  final void Function()? onInvoiceStore;

  const TableMenuBottmSheet({
    Key? key,
    this.onDelete,
    this.onRename,
    this.onNewInvoice,
    this.onInvoiceStore,
  }) : super(key: key);

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
          const SizedBox(height: 10),
          CustomBottomSheetItem(
            icon: Icons.receipt_long_rounded,
            title: "استخراج فتورة جديدة",
            onTap: () {
              if (onNewInvoice != null) onNewInvoice!();
            },
          ),
          CustomBottomSheetItem(
            icon: Icons.archive_outlined,
            title: "الفواتير",
            onTap: () {
              if (onInvoiceStore != null) onInvoiceStore!();
            },
          ),
          CustomBottomSheetItem(
            icon: Icons.edit_rounded,
            title: "تغير اسم الجدول",
            onTap: () {
              if (onRename != null) onRename!();
            },
          ),
          CustomBottomSheetItem(
            icon: Icons.delete_outline_rounded,
            title: "مسح الجدول",
            color: Colors.red,
            onTap: () {
              if (onDelete != null) onDelete!();
            },
          ),
        ],
      ),
    );
  }
}
