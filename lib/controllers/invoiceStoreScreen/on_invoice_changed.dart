import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/controllers/invoiceStoreScreen/index.dart';

class OnInvoiceChangedController {
  final InvoiceStoreScreenController controller;

  OnInvoiceChangedController(this.controller);

  Future<void> onInvoiceChanged(int invoiceId) async {
    customLoadingDailog(text: "المرجو الانتضار");
    final res = await InvoicesApi().getLinkedInvoices(invoiceId);
    Get.back();
    if (res.isSuccess && res.hasData) {
      final tables = effectedTableInvoices(res.data);
      for (final table in tables.entries) {
        updateEffectedInvoiceOfTable(table);
      }
      controller.refrechInvoices();
    }
  }

  /// Return table index of the [tables] as key of Map Object and the
  /// value of the object is the list of invoiceIds for the table
  ///
  ///
  Map<int, List<Invoice>> effectedTableInvoices(List<Invoice> data) {
    Map<int, List<Invoice>> tableInvoices = {};

    for (Invoice linked in data) {
      int index = controller.tables.indexWhere((table) => table.tableId == linked.tableId);
      final table = tableInvoices[index];

      if (table != null) {
        table.add(linked);
        continue;
      }

      if (index != -1) {
        tableInvoices.addAll({
          index: [linked]
        });
      }
    }
    return tableInvoices;
  }

  updateEffectedInvoiceOfTable(MapEntry<int, List<Invoice>> tableInvoices) {
    TableInvoices table = controller.tables[tableInvoices.key];
    for (Invoice invoice in tableInvoices.value) {
      int index = table.invoices.indexWhere((e) => e.invoiceId == invoice.invoiceId);
      if (index != -1) table.invoices[index] = invoice;
    }
  }
}
