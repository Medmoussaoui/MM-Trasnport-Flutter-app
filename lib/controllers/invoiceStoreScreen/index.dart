import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/invoiceStoreScreen/delete_invoices.dart';
import 'package:mmtransport/controllers/invoiceStoreScreen/on_invoice_changed.dart';

class InvoiceStoreScreenController extends GetxController {
  late ScrollController scrollController;
  late Function? onOut;

  List<TableInvoices> tables = [];

  ValueNotifier<bool> selectMode = ValueNotifier(false);

  RxList<Invoice> invoicesSelect = RxList();

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
          onInvoiceChanged(invoice.invoiceId!);
        }
      },
    );
  }

  onInvoiceChanged(int invoiceId) {
    OnInvoiceChangedController(this).onInvoiceChanged(invoiceId);
  }

  onInvoiceSearchChanged(List<Invoice> linkedInvocies) {
    final controller = OnInvoiceChangedController(this);
    final tables = controller.effectedTableInvoices(linkedInvocies);
    for (final table in tables.entries) {
      controller.updateEffectedInvoiceOfTable(table);
    }
    refrechInvoices();
  }

  deleteInvoices() {
    InvoiceStoreDeleteInvoicesController(this).deleteInvoices();
  }

  refrechInvoices() {
    getDataRequest.value = StatusRequest(data: tables).success();
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
    final res = await InvoicesApi().getAllTableInvoices(pageIndex.value);
    if (res.isSuccess && res.hasData) {
      tables = res.data;
    }
    getDataRequest.value = res;
  }

  loadData() async {
    getDataRequest.value = getDataRequest.value.loading();
    final res = await InvoicesApi().getAllTableInvoices(pageIndex.value);
    if (res.isSuccess) {
      if (res.hasData) tables.addAll(res.data);
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
    List<TableInvoices> filter = [];
    for (var table in tables) {
      final invoices = table.invoices.where((invoice) => invoice.payStatus == "unpaid").toList();
      if (invoices.isNotEmpty) {
        filter.add(TableInvoices(
          tableId: table.tableId,
          tableName: table.tableName,
          invoices: invoices,
        ));
      }
    }
    getDataRequest.value = StatusRequest(data: filter).success();
  }

  showpaidInvoices() {
    List<TableInvoices> filter = [];
    for (var table in tables) {
      final invoices = table.invoices.where((invoice) => invoice.payStatus == "paid").toList();
      if (invoices.isNotEmpty) {
        filter.add(TableInvoices(
          tableId: table.tableId,
          tableName: table.tableName,
          invoices: invoices,
        ));
      }
    }
    getDataRequest.value = StatusRequest(data: filter).success();
  }

  showPaidAndUnPaidInvoices() {
    getDataRequest.value = StatusRequest(data: tables).success();
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
    onOut = Get.arguments["onOut"];
  }

  @override
  void onClose() {
    if (onOut != null) onOut!();
    scrollController.dispose();
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
