import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/custom_internal_server_problem.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/Dialogs/no_internet_dialog.dart';
import 'package:mmtransport/Components/Dialogs/primary.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/sounds.dart';

class FindInvoiceScreenController extends GetxController {
  late Function(Invoice invoice) onInvoiceChnaged;

  Invoice? invoiceChanged;

  String barcode = "";

  getInvoiceId(String code) {
    // Invoice Id
    return code.substring(2, code.length);
  }

  onSacnBarCode(String code) {
    if (barcode.isNotEmpty) return;
    barcode = code;
    AppAudio.scanCode();
    findInvoice();
  }

  findInvoice() async {
    String invoiceId = getInvoiceId(barcode);
    customLoadingDailog(text: "جري البحث");
    await Future.delayed(const Duration(milliseconds: 500));
    StatusRequest res = await InvoicesApi().getInvoiceById(invoiceId);
    Get.back();
    await Future.delayed(const Duration(milliseconds: 300));
    await handleRespone(res);
  }

  handleRespone(StatusRequest res) async {
    if (res.isSuccess) return redirectToInvoicePreview(res.data);
    if (res.isRespondError) return noInvoiceFound();
    if (res.isConnectionError) return noInternetDialog(onTap: reScan);
    if (res.isServerFailer) return serverFailer();
  }

  redirectToInvoicePreview(Invoice invoice) {
    return RedirectTo.invoiceScreen(
      invoice: invoice,
      onUpdated: (change, invoice) {
        if (change) invoiceChanged = invoice;
        reScan();
      },
    );
  }

  serverFailer() async {
    bool tryAgain = false;
    await customInternalServerErrorDialog(ontap: () => tryAgain = true);
    if (tryAgain) return await findInvoice();
    reScan();
  }

  tryFindAgain() => findInvoice();

  reScan() => barcode = "";

  noInvoiceFound() async {
    await customPrimaryDialog(
      title: "لاتوجد فاتورة",
      subTitle: " نعتذر لم يتم ايجاد اي فاتورة بهذا الرمز يمكنك المحاولة برمز اخر",
      icon: Icons.visibility_off_outlined,
      color: Colors.grey,
      onTap: () {
        Get.back();
        reScan();
      },
    );
  }

  initialArgs() {
    onInvoiceChnaged = Get.arguments["onInvoiceChanged"];
  }

  @override
  void onClose() {
    if (invoiceChanged != null) {
      onInvoiceChnaged(invoiceChanged!);
    }
    super.onClose();
  }

  @override
  void onInit() {
    initialArgs();
    super.onInit();
  }
}
