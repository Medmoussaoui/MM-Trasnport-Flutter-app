import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/custom_confirm_delete_dialog.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/TableInvoiceStore/index.dart';

class TableInvoiceStoreDeleteInvoices {
  final TableInvoicesStoreScreenController controller;

  TableInvoiceStoreDeleteInvoices(this.controller);

  List<int> getInvoiceIds() {
    return controller.invoicesSelect.map((invoice) => invoice.invoiceId!).toList();
  }

  String _invoiceName() {
    return controller.invoicesSelect.length > 1 ? "الفواتير" : "الفاتورة";
  }

  Future<bool> showConfirmDialog() async {
    bool delete = false;
    await customConfirmDeleteDialog(
      subTitle: "سيتم فقد ${_invoiceName()} بشكل نهائي عند عملية الحذف",
      onAccept: () async {
        delete = true;
        Get.back();
      },
    );
    return delete;
  }

  deleteInvoices() async {
    bool accept = await showConfirmDialog();
    if (!accept) return;
    customLoadingDailog(text: "جري الحذف", onWillPop: () async => false);
    StatusRequest res = await InvoicesApi().deleteInvoices(getInvoiceIds());
    Get.back();
    if (res.isSuccess) {
      AppSnackBars.successDeleteServices();
      deleteInvoicesFomLocalList();
      controller.disableSelectMode();
      return;
    }
    if (res.isConnectionError) {
      return AppSnackBars.noInternetAccess();
    }
  }

  deleteInvoicesFomLocalList() {
    controller.invoices.removeWhere(
      (invoice) => controller.invoicesSelect.contains(invoice),
    );
    controller.refrechInvoices();
  }
}
