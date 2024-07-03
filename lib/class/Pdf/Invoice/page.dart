import 'dart:typed_data';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/class/Pdf/Invoice/build_green_sticker.dart';
import 'package:mmtransport/class/Pdf/Invoice/build_inoice_header.dart';
import 'package:mmtransport/class/Pdf/Invoice/build_invoice_payment_status.dart';
import 'package:mmtransport/class/Pdf/Invoice/build_invoice_table.dart';
import 'package:mmtransport/class/Pdf/Invoice/builld_total_summery.dart';
import 'package:mmtransport/class/Pdf/index.dart';
import 'package:pdf/widgets.dart';

class InvoicePdf {
  final MemoryImage logo;
  final Invoice invoice;

  InvoicePdf(this.logo, this.invoice);

  Future<Uint8List> build() async {
    return await AppPdf.generatePdf([
      InvoiceHeader(invoice, logo).build(),
      InvoiceGreenSticker(invoice).build(),
      InvoicePaymentStatus(invoice).build(),
      InvoiceTableData(invoice).build(),
      SizedBox(height: 20),
      addTotalSummaryAndFoter()
    ]);
  }

  Widget addTotalSummaryAndFoter() {
    return Wrap(children: [
      InvoiceTotalSummary(invoice).build(),
      // InvoiceFoterSection().build(),
    ]);
  }
}
