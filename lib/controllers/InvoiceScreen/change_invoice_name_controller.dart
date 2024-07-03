import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/handle_api_responce_ui.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/InvoiceScreen/index.dart';

class ChangeInvoiceNameController {
  final Invoice invoice;

  late ValueNotifier<StatusRequest> request;
  late TextEditingController formController = TextEditingController();

  ChangeInvoiceNameController(this.invoice) {
    formController = TextEditingController(text: invoice.invoiceName);
    request = ValueNotifier(StatusRequest());
  }

  change() async {
    if (formController.text.isEmpty) return;
    request.value = request.value.loading();
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await InvoicesApi().changeInvoiceName(
      formController.text,
      invoice.invoiceId!,
    );
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    request.value = HandleApiResponceUi(
      onSuccess: (res) {
        updateInvoiceName();
        AppSnackBars.successChangeInvoiceName();
      },
    ).handle(res);
  }

  updateInvoiceName() {
    final ref = Get.find<InvoiceScreenController>();
    ref.invoice.invoiceName = formController.text;
    ref.invoiceChanged();
  }
}
