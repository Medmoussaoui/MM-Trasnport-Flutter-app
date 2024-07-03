import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Data/Api/invoices.api.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/snackbars.dart';

class InvoiceSearchScreenController extends GetxController {
  ValueNotifier<StatusRequest> searchRequest = ValueNotifier(StatusRequest());
  late TextEditingController formController;
  late ScrollController scrollController;
  late Function(List<Invoice> linked) onInvoiceChnaged;

  RxInt pageIndex = 0.obs;

  // For load data on Scroling
  RxBool onLoad = false.obs;

  List<Invoice> invoices = [];
  List<Invoice> linkedInvoices = [];

  refrechButton() async {
    bool hasConnection = await hasInternet();
    if (!hasConnection) return AppSnackBars.noInternetAccess();
    findInvoiceByName(formController.text);
  }

  redirectToInvoicePreview(Invoice invoicePreview) {
    RedirectTo.invoiceScreen(
      invoice: invoicePreview,
      onUpdated: (change, invoice) {
        if (change) _onInvoiceChanged(invoice.invoiceId!);
      },
    );
  }

  Future<void> _onInvoiceChanged(int invoiceId) async {
    customLoadingDailog(text: "المرجو الانتضار");
    final res = await InvoicesApi().getLinkedInvoices(invoiceId);
    Get.back();
    if (res.isSuccess && res.hasData) {
      linkedInvoices = res.data;
      for (Invoice linked in res.data) {
        int index = invoices.indexWhere((invoice) => invoice.invoiceId == linked.invoiceId);
        if (index != -1) invoices[index] = linked;
      }
      refrechInvoices();
    }
  }

  refrechInvoices() {
    searchRequest.value = StatusRequest(data: invoices).success();
  }

  defaultMode() {
    invoices.clear();
    searchRequest.value = StatusRequest();
  }

  findInvoiceByName(String input) async {
    if (input.trim().isEmpty) return defaultMode();
    searchRequest.value = searchRequest.value.loading();
    pageIndex.value = 0;
    final res = await InvoicesApi().search(input, pageIndex.value);
    if (formController.text.isEmpty) return defaultMode();
    if (res.isSuccess && res.hasData) invoices = List.from(res.data);
    searchRequest.value = res;
  }

  loadData() async {
    onLoad.value = true;
    searchRequest.value.loading();
    final res = await InvoicesApi().search(formController.text, pageIndex.value);

    if (res.isSuccess) {
      if (res.hasData) invoices.addAll(res.data);
      if (!res.hasData) pageIndex.value = -1;
    }
    onLoad.value = false;
    refrechInvoices();
  }

  loadItemsOnScrolling() async {
    double rangeStartLoadingData = scrollController.position.maxScrollExtent - 30;
    if (scrollController.position.pixels <= rangeStartLoadingData) return;
    if (searchRequest.value.isLoading) return;
    if (pageIndex.value == -1) return;
    pageIndex++;
    loadData();
  }

  initialArgs() {
    onInvoiceChnaged = Get.arguments["onInvoiceChanged"];
  }

  @override
  void onInit() {
    initialArgs();
    formController = TextEditingController();
    scrollController = ScrollController();

    scrollController.addListener(() {
      loadItemsOnScrolling();
    });

    super.onInit();
  }

  @override
  void onClose() {
    formController.dispose();
    scrollController.dispose();
    if (linkedInvoices.isNotEmpty) {
      onInvoiceChnaged(linkedInvoices);
    }
    super.onClose();
  }
}
