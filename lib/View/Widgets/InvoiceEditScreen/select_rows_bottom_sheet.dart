import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_item.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';

import 'package:mmtransport/Constant/app.color.dart';

class InvoiceEditSelectBottomSheet extends StatelessWidget {
  final bool showEditItem;
  final bool showMoreInfoItem;
  final void Function()? onEdit;
  final void Function()? onMoreInfo;
  final void Function()? onDelete;

  const InvoiceEditSelectBottomSheet({
    required this.showEditItem,
    required this.showMoreInfoItem,
    super.key,
    this.onEdit,
    this.onMoreInfo,
    this.onDelete,
  });

  Widget _edit() {
    if (showEditItem) {
      return CustomBottomSheetItem(
        icon: Icons.edit_outlined,
        title: "تعديل البيانات",
        onTap: () {
          if (onEdit != null) onEdit!();
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _moreInfo() {
    if (showMoreInfoItem) {
      return CustomBottomSheetItem(
        icon: Icons.info_outline_rounded,
        title: "معلومات اكثر",
        onTap: () {
          if (onMoreInfo != null) onMoreInfo!();
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
          const SizedBox(height: 10),
          _edit(),
          _moreInfo(),
          CustomBottomSheetItem(
            icon: Icons.delete_outline_rounded,
            title: "مسح العناصر",
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
