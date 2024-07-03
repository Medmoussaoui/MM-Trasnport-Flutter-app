import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/InvoiceScreen/index.dart';

class InvoiceScreenCustomIconsBar extends GetView<InvoiceScreenController> {
  const InvoiceScreenCustomIconsBar({super.key});

  Widget editButton() {
    bool canEdit = controller.canChangeInvoiceState();
    return AbsorbPointer(
      absorbing: !canEdit,
      child: IconButton(
        onPressed: () {
          controller.editInvoice();
        },
        splashRadius: 23,
        icon: Icon(Icons.edit_rounded, color: !canEdit ? AppColors.geyDeep : null),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton(
          onPressed: () {
            controller.dowaloadPdf();
          },
          splashRadius: 23,
          icon: const Icon(Icons.file_download_outlined, size: 29),
        ),
        IconButton(
          onPressed: () {
            controller.shareInvoice();
          },
          splashRadius: 23,
          icon: const Icon(Icons.share_rounded),
        ),
        editButton(),
      ],
    );
  }
}
