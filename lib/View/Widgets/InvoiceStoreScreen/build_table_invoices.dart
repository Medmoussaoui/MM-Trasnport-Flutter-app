import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card.dart';
import 'package:mmtransport/View/Widgets/moreInfoScreen/custom_widget_title.dart';
import 'package:mmtransport/controllers/invoiceStoreScreen/index.dart';

class BuildTableInvoices extends StatelessWidget {
  final TableInvoices tableInvoices;

  const BuildTableInvoices({
    super.key,
    required this.tableInvoices,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceStoreScreenController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomWidgetTitle(
          title: tableInvoices.tableName ?? "بدون جدول",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),
        ),
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 240,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              return Hero(
                tag: tableInvoices.invoices[index].invoiceId.toString(),
                child: Material(
                  child: CustomInvoiceCard(
                    onPresss: controller.redirectToInvoicePreview,
                    onSelect: (invoice) {
                      controller.selectInvoice(invoice);
                    },
                    isSelect: controller.isInvoiceSelected,
                    onLongPresss: controller.enableSelectMode,
                    selectMode: controller.selectMode,
                    invoice: tableInvoices.invoices[index],
                  ),
                ),
              );
            },
            itemCount: tableInvoices.invoices.length,
          ),
        ),
      ],
    );
  }
}
