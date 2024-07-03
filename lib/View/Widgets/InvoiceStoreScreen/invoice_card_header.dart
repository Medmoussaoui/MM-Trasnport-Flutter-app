import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_label_state.dart';

class InvoiceCardCustomNameAndState extends StatelessWidget {
  final Invoice invoice;
  const InvoiceCardCustomNameAndState({
    super.key,
    required this.invoice,
  });

  String _invoiceName() {
    if (invoice.invoiceName == null) return "#${invoice.invoiceId}";
    if (invoice.invoiceName == "") return "#${invoice.invoiceId}";
    if (invoice.invoiceName == "non") return "#${invoice.invoiceId}";
    return invoice.invoiceName!;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FittedBox(
              child: CustomLargeTitle(title: _invoiceName(), size: 12),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: (Get.width * 0.5) * 0.3,
          child: Builder(
            builder: (_) {
              bool isPaid = invoice.payStatus == "paid";
              bool isInvoiceInactive = invoice.inactive == true;
              if (isPaid) {
                return InvoiceCardCustomLabelState(
                  value: "مدفوعة",
                  fillColor: isInvoiceInactive ? AppColors.geyDeep : AppColors.therdColor,
                );
              }
              return InvoiceCardCustomLabelState(
                value: "غير مدفوعة",
                fillColor: isInvoiceInactive ? AppColors.geyDeep : Colors.orange[600]!,
              );
            },
          ),
        ),
      ],
    );
  }
}
