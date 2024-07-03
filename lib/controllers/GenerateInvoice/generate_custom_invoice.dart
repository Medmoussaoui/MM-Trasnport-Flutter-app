import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/no_internet_dialog.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';

class GenerateCustomInvoiceController {
  final List<int> serviceIds;
  final int? tableId;
  final String? initialInvoiceName;
  ValueNotifier<StatusRequest> request = ValueNotifier(StatusRequest());
  late TextEditingController formController;

  GenerateCustomInvoiceController({
    this.initialInvoiceName,
    required this.serviceIds,
    this.tableId,
  }) {
    formController = TextEditingController(text: initialInvoiceName);
  }

  onTapContinue() async {
    request.value = request.value.loading();
    String input = formController.text;
    request.value = await InvoicesApi().generateCustomInvoice(
      serviceIds,
      invoiceName: input.isEmpty ? null : input,
      tableId: tableId,
    );
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    if (request.value.isSuccess) {
      return RedirectTo.invoiceScreen(invoice: request.value.data);
    }
    if (request.value.isConnectionError) {
      return noInternetDialog();
    }
  }
}
