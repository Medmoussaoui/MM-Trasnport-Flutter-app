import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class InvoiceGreenSticker {
  final Invoice invoice;

  InvoiceGreenSticker(this.invoice);

  Widget build() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      width: double.infinity,
      height: 75,
      color: PdfColor.fromHex("#4caf50"),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            height: double.infinity,
            width: 190,
            decoration: BoxDecoration(
              color: PdfColor.fromHex("#FFFFFF"),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Center(
              child: BarcodeWidget(
                data: "IV${invoice.invoiceId}",
                barcode: Barcode.code128(),
                drawText: false,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          Spacer(),
          Text(
            invoice.invoiceName!,
            style: TextStyle(
              color: PdfColor.fromHex("#FFFFFF"),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
