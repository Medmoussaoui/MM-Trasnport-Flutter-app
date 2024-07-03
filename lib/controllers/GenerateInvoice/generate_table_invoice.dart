import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/no_internet_dialog.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/GenerateInvoice/generate_custom_invoice.dart';

class GenereteTableInvoiceController implements GenerateCustomInvoiceController {
  final TableEntity table;

  GenereteTableInvoiceController(this.table) {
    formController = TextEditingController(text: initialInvoiceName);
  }

  @override
  late TextEditingController formController;

  @override
  ValueNotifier<StatusRequest> request = ValueNotifier(StatusRequest());

  @override
  String? get initialInvoiceName => table.tableName;

  String invoiceName() {
    if (formController.text.isEmpty) return table.tableName!;
    return formController.text;
  }

  tableNeedSync() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    AppSnackBars.tableNeedSync();
  }

  @override
  onTapContinue() async {
    request.value = request.value.loading();

    if (table.tableId == null) return tableNeedSync();

    request.value = await InvoicesApi().generateTableInvoice(invoiceName(), table.tableId!);
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    if (request.value.isSuccess) {
      return RedirectTo.invoiceScreen(invoice: request.value.data);
    }
    if (request.value.isConnectionError) {
      return noInternetDialog();
    }
  }

  @override
  List<int> get serviceIds => [];

  @override
  int? get tableId => table.tableId;
}
