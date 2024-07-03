import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_table_row.dart';

class InvoiceCardServices extends StatelessWidget {
  final Invoice invoice;

  const InvoiceCardServices({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gey.withOpacity(0.2),
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: ListView.builder(
        primary: false,
        itemCount: invoice.services!.length > 5 ? 5 : invoice.services!.length,
        itemBuilder: (context, index) {
          return InvoiceCardTableRow(
            service: invoice.services![index],
          );
        },
      ),
    );
  }
}
