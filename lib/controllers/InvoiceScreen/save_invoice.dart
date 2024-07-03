import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/custom_confirm_dialog.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/syncData/Containers/sync_save_invoices.dart';

class SaveInvoiceController {
  final int invoiceId;

  SaveInvoiceController(this.invoiceId);

  askForSave() async {
    bool save = await showConfirmDialog();
    if (save) await _save();
  }

  Future<bool> showConfirmDialog() async {
    bool save = false;
    await customConfirmDialog(
      icon: Icons.save_rounded,
      color: AppColors.secondColor,
      confirmButtonColor: AppColors.secondColor,
      onAccept: () {
        save = true;
        Get.back();
      },
      title: "حفض الفاتورة",
      subTitle: "اذا كنت تريد حفض الفاتورة قم بالضغط على حفض",
      confirmTitle: "حفض",
      cancelTitle: "تجاهل",
    );
    return save;
  }

  Future<void> _save() async {
    customLoadingDailog(text: "جري الحفض", onWillPop: () async => false);
    StatusRequest res = await InvoicesApi().saveInvoice(invoiceId);
    Get.back();
    if (res.isSuccess) return AppSnackBars.successSaveInvoice();
    await SyncSaveInvoices.addToSync(invoiceId);
  }
}
