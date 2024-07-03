import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/app_bar.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/loading_invoices.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/select_mode_app_bar.dart';
import 'package:mmtransport/View/Widgets/TableInvvoicesStore/content_body.dart';
import 'package:mmtransport/controllers/TableInvoiceStore/index.dart';

class TableInvoicesStoreScreen extends StatelessWidget {
  const TableInvoicesStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TableInvoicesStoreScreenController());
    controller.getTableInvoices();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// Content App Bar
            SliverPersistentHeader(
              floating: true,
              pinned: true,
              delegate: InvoiceCustomSliverAppBar(
                expandedHeight: 150,
                onNavigate: controller.onNavBarTap,
                navBarGroupValue: controller.navBarGroupValue,
                expandAppBarTite: controller.table.tableName,
                onScanInvoiceChnaged: (invoice) {
                  controller.onInvoiceChanged(invoice.invoiceId!);
                },
                onSearchInvoiceChanged: (linkedInvoices) {
                  controller.onInvoiceSearchChnaged(linkedInvoices);
                },
                selectModeAppBar: CustomInvoiceStoreSelectModeAppBar(
                  onClose: controller.disableSelectMode,
                  onDelete: () {
                    controller.deleteInvoices();
                  },
                  selectMode: controller.selectMode,
                  selectList: controller.invoicesSelect,
                ),
              ),
            ),

            /// Content body
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              sliver: TableInvoicesStoreContentBody(
                request: controller.getDataRequest,
                refrechButton: controller.refrechButton,
              ),
            ),

            SliverToBoxAdapter(
              child: InvoiceStoreLoadingInvoices(
                request: controller.getDataRequest,
                onEnd: () => controller.pageIndex.value == -1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
