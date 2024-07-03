import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';
import 'package:mmtransport/View/Screens/pdf_preview.dart';
import 'package:mmtransport/View/Widgets/InvoiceScreen/change_invoice_name_bottom_sheet.dart';
import 'package:mmtransport/View/Widgets/InvoiceScreen/edit_menu_bottom_sheet.dart';
import 'package:mmtransport/class/Pdf/Invoice/page.dart';
import 'package:mmtransport/class/Pdf/index.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/handle_api_responce_ui.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/class/sounds.dart';
import 'package:mmtransport/controllers/InvoiceScreen/change_invoice_name_controller.dart';
import 'package:mmtransport/controllers/InvoiceScreen/download_invoice_pdf.dart';
import 'package:mmtransport/controllers/InvoiceScreen/save_invoice.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceScreenController extends GetxController {
  late Invoice invoice;
  late RxInt payStatus;

  /// for custom implement [change] has the value of [isInvoiceUpdated] to make any
  /// action on the  chnaged invoice
  ///
  ///
  late Function(bool change, Invoice invoice) onUpdated;

  /// if we make any changes on the current invoice the [isInvoiceUpdated]
  /// will be true to we will know this invoice is chnaged to make any
  /// action we need
  ///
  ///
  bool isInvoiceUpdated = false;

  ValueNotifier<bool> refrechInvoice = ValueNotifier(false);

  editInvoice() {
    customShowBottoSheet(const InvoiceEditBottomSheet());
  }

  Future<Uint8List> generateInvoicePdf() async {
    await AppPdf.initi();
    final logo = pw.MemoryImage((await rootBundle.load(AppImages.truck)).buffer.asUint8List());
    return await InvoicePdf(logo, invoice).build();
  }

  shareInvoice() async {
    await Future.delayed(const Duration(milliseconds: 180));
    customLoadingDailog(text: "المرجو النتضار");
    final pdf = await generateInvoicePdf();
    Get.back();
    String fileName = getInvoicFileName();
    Navigator.of(Get.context!).push(MaterialPageRoute(
      builder: (_) => PdfPagePreview(ourPdf: pdf, pdfName: fileName),
    ));
  }

  String getInvoicFileName() {
    final now = DateTime.now();
    final date = dateToHafen(getDate(now.toString()));
    return "Facture (#${invoice.invoiceId}) - ($date) - (${invoice.invoiceName}).pdf";
  }

  Future dowaloadPdf() async {
    await Future.delayed(const Duration(milliseconds: 180));
    DownloadInvoicePdf(this).dowload();
  }

  editInvoiceTable() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    RedirectTo.invoiceEditScreen(
      invoice: invoice,
      onEdit: (edit) {
        if (edit) {
          isInvoiceUpdated = true;
          invoiceChanged();
        }
      },
    );
  }

  changeInvoiceName() async {
    Get.back();
    await Future.delayed(const Duration(milliseconds: 200));
    customShowBottoSheet(
      isDismissible: false,
      ChangeInvoieNameBottomSheet(
        controller: ChangeInvoiceNameController(invoice),
      ),
    );
  }

  canChangeInvoiceState() {
    return invoice.inactive == false || invoice.inactive == null;
  }

  initialPayStatus() {
    if (invoice.payStatus == "unpaid") return payStatus = 0.obs;
    payStatus = 1.obs;
  }

  initialArgs() {
    invoice = Get.arguments["invoice"];
    onUpdated = Get.arguments["onUpdated"];
    initialPayStatus();
  }

  onInvoicePayStatusChange(int value) async {
    if (payStatus.value == value) return;
    int oldValue = payStatus.value;
    payStatus.value = value;
    customLoadingDailog(text: "المرجو الانتضار", onWillPop: () async => false);

    final res = await invoicePayment();
    Get.back();
    HandleApiResponceUi(
      onSuccess: (res) {
        if (value == 1) return successPaid(res.data);
        successUnPaid(res.data);
      },
    ).handle(res);

    if (!res.isSuccess) payStatus.value = oldValue;
  }

  Future<StatusRequest> invoicePayment() async {
    if (payStatus.value == 0) return markInvoiceUnPaid();
    return markInvoicePaid();
  }

  Future<StatusRequest> markInvoicePaid() async {
    return InvoicesApi().invoicePayment(invoice.invoiceId!, "paid");
  }

  Future<StatusRequest> markInvoiceUnPaid() async {
    return InvoicesApi().invoicePayment(invoice.invoiceId!, "unpaid");
  }

  successPaid(Invoice invoice) {
    AppAudio.paySuccess();
    AppSnackBars.successPayInvoice();
    updateInvoice(invoice);
  }

  successUnPaid(Invoice invoice) {
    AppSnackBars.successUnPayInvoice();
    updateInvoice(invoice);
  }

  invoiceChanged() {
    refrechInvoice.value = !refrechInvoice.value;
  }

  onOut() async {
    if (invoice.save == 0) {
      return await SaveInvoiceController(invoice.invoiceId!).askForSave();
    }
  }

  updateInvoice(Invoice invoice) {
    isInvoiceUpdated = true;
    this.invoice.invoiceName = invoice.invoiceName;
    this.invoice.tableId = invoice.tableId;

    this.invoice.dateCreate = invoice.dateCreate;
    this.invoice.padiDate = invoice.padiDate;
    this.invoice.payStatus = invoice.payStatus;
    this.invoice.save = invoice.save;

    this.invoice.finalTotal = invoice.finalTotal;
    this.invoice.totalPayingOff = invoice.totalPayingOff;
    this.invoice.totalSummation = invoice.totalSummation;
    this.invoice.services = invoice.services;

    invoiceChanged();
  }

  @override
  void onClose() {
    onUpdated(isInvoiceUpdated, invoice);
    super.onClose();
  }

  @override
  void onInit() {
    initialArgs();
    super.onInit();
  }
}
