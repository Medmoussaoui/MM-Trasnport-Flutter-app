import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/TableInvoiceStore/delete_invoices.dart';

class TableInvoicesStoreScreenController extends GetxController {
  late ScrollController scrollController;
  late TableEntity table;
  late Function? onOut;

  refrechButton() async {
    bool hasConnection = await hasInternet();
    if (!hasConnection) return AppSnackBars.noInternetAccess();
    getTableInvoices();
  }

  redirectToInvoicePreview(Invoice invoicePreview) {
    RedirectTo.invoiceScreen(
      invoice: invoicePreview,
      onUpdated: (change, invoice) {
        if (change) {
          invoicePreview = invoice;
          onInvoiceChanged(invoice.invoiceId!);
        }
      },
    );
  }

  Future<void> onInvoiceChanged(int invoiceId) async {
    customLoadingDailog(text: "المرجو الانتضار");
    final res = await InvoicesApi().getLinkedInvoices(invoiceId);
    Get.back();
    if (res.isSuccess && res.hasData) {
      for (Invoice linked in res.data) {
        int index = invoices.indexWhere((invoice) => invoice.invoiceId == linked.invoiceId);
        if (index != -1) invoices[index] = linked;
      }
      refrechInvoices();
    }
  }

  onInvoiceSearchChnaged(List<Invoice> linkedInvoices) async {
    await Future.delayed(const Duration(milliseconds: 400));
    for (Invoice linked in linkedInvoices) {
      int index = invoices.indexWhere((invoice) => invoice.invoiceId == linked.invoiceId);
      if (index != -1) invoices[index] = linked;
    }
    refrechInvoices();
  }

  List<Invoice> invoices = [];

  ValueNotifier<bool> selectMode = ValueNotifier(false);

  RxList<Invoice> invoicesSelect = RxList();

  deleteInvoices() {
    TableInvoiceStoreDeleteInvoices(this).deleteInvoices();
  }

  refrechInvoices() {
    getDataRequest.value = StatusRequest(data: invoices).success();
  }

  void enableSelectMode(Invoice? invoice) {
    if (selectMode.value) return;
    if (invoice != null) selectInvoice(invoice);
    selectMode.value = true;
  }

  disableSelectMode() {
    selectMode.value = false;
    invoicesSelect.clear();
    refrechInvoices();
  }

  selectInvoice(Invoice invoice) {
    if (isInvoiceSelected(invoice)) return invoicesSelect.remove(invoice);
    invoicesSelect.add(invoice);
  }

  bool isInvoiceSelected(Invoice invoice) {
    return invoicesSelect.contains(invoice);
  }

  late ValueNotifier<StatusRequest> getDataRequest = ValueNotifier(StatusRequest());

  RxInt pageIndex = 0.obs;
  RxInt navBarGroupValue = 0.obs;

  Future<void> getTableInvoices() async {
    getDataRequest.value = getDataRequest.value.loading();

    if (table.tableId == null) {
      getDataRequest.value = StatusRequest(data: []).success();
      return;
    }

    final res = await InvoicesApi().getTableInvoices(table.tableId!, pageIndex.value);
    if (res.isSuccess && res.hasData) invoices = List.from(res.data);
    getDataRequest.value = res;
  }

  loadData() async {
    getDataRequest.value = getDataRequest.value.loading();
    final res = await InvoicesApi().getTableInvoices(table.tableId!, pageIndex.value);
    if (res.isSuccess) {
      if (res.hasData) invoices.addAll(res.data);
      if (!res.hasData) pageIndex.value = -1;
    }
    refrechInvoices();
  }

  loadItemsOnScrolling() async {
    double rangeStartLoadingData = scrollController.position.maxScrollExtent - 30;
    if (scrollController.position.pixels <= rangeStartLoadingData) return;
    if (getDataRequest.value.isLoading) return;
    if (pageIndex.value == -1) return;
    pageIndex++;
    loadData();
  }

  showUnpaidInvoices() {
    final filter = invoices.where((invoice) => invoice.payStatus == "unpaid").toList();
    getDataRequest.value = StatusRequest(data: filter).success();
  }

  showpaidInvoices() {
    final filter = invoices.where((invoice) => invoice.payStatus == "paid").toList();
    getDataRequest.value = StatusRequest(data: filter).success();
  }

  showPaidAndUnPaidInvoices() {
    getDataRequest.value = StatusRequest(data: invoices).success();
  }

  onNavBarTap(int value) async {
    navBarGroupValue.value = value;
    getDataRequest.value = StatusRequest(data: []).loading();
    await Future.delayed(const Duration(milliseconds: 700));
    if (navBarGroupValue.value == 0) return showPaidAndUnPaidInvoices();
    if (navBarGroupValue.value == 1) return showpaidInvoices();
    if (navBarGroupValue.value == 2) return showUnpaidInvoices();
  }

  initialArgs() {
    table = Get.arguments["table"];
    onOut = Get.arguments["onOut"];
  }

  @override
  void onClose() {
    scrollController.dispose();
    if (onOut != null) onOut!();
    super.onClose();
  }

  @override
  void onInit() {
    initialArgs();
    scrollController = ScrollController();
    scrollController.addListener(() => loadItemsOnScrolling());
    super.onInit();
  }
}
