import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/app_bar.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/content_body.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/loading_invoices.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/select_mode_app_bar.dart';
import 'package:mmtransport/controllers/invoiceStoreScreen/index.dart';

class InvoiceStoreScreen extends StatelessWidget {
  const InvoiceStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceStoreScreenController());
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
                onScanInvoiceChnaged: (invoice) {
                  controller.onInvoiceChanged(invoice.invoiceId!);
                },
                onSearchInvoiceChanged: (linked) {
                  controller.onInvoiceSearchChanged(linked);
                },
                selectModeAppBar: CustomInvoiceStoreSelectModeAppBar(
                  onClose: controller.disableSelectMode,
                  onDelete: controller.deleteInvoices,
                  selectMode: controller.selectMode,
                  selectList: controller.invoicesSelect,
                ),
              ),
            ),

            /// Content body
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              sliver: InvoiceStoreContentBody(
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
