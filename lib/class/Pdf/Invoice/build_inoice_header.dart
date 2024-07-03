import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:pdf/widgets.dart';

import '../../../Functions/dates.dart';

class InvoiceHeader {
  final Invoice invoice;
  final MemoryImage logo;
  InvoiceHeader(this.invoice, this.logo);

  Widget build() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
      child: Row(
        children: [
          Text(
            getDateAndTime(invoice.dateCreate!),
            style: const TextStyle(fontSize: 17.0),
          ),
          Spacer(),
          Image(logo, height: 50),
        ],
      ),
    );
  }
}
