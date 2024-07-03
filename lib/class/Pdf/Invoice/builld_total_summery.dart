import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class InvoiceTotalSummary {
  final Invoice invoice;

  InvoiceTotalSummary(this.invoice);

  Widget build() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        height: 90,
        width: 400,
        child: Column(
          children: [
            Expanded(child: TotalPayingOff().build(-invoice.totalPayingOff!)),
            Expanded(child: FinalTotal().build(invoice.finalTotal!)),
          ],
        ),
      ),
    );
  }
}

class TotalPayingOff {
  Widget build(int price) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              border: Border.all(color: PdfColor.fromHex("#323232"), width: 0.4),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10)),
              color: PdfColor.fromHex("#F9F9F9"),
            ),
            child: FittedBox(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    "درهم",
                    style: TextStyle(
                      color: PdfColor.fromHex("#FF0000"),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "$price",
                    style: TextStyle(
                      color: PdfColor.fromHex("#FF0000"),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              border: Border.all(color: PdfColor.fromHex("#323232"), width: 0.4),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(10)),
              color: PdfColor.fromHex("#000000"),
            ),
            child: FittedBox(
              alignment: Alignment.center,
              child: Text(
                "مجموع الدفع",
                style: TextStyle(
                  color: PdfColor.fromHex("#FFFFFF"),
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class FinalTotal {
  Widget build(int price) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              border: Border.all(color: PdfColor.fromHex("#323232"), width: 0.4),
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10)),
              color: PdfColor.fromHex("#F9F9F9"),
            ),
            child: FittedBox(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    "درهم",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    "$price",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
              border: Border.all(color: PdfColor.fromHex("#323232"), width: 0.4),
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10)),
              color: PdfColor.fromHex("#000000"),
            ),
            child: FittedBox(
              alignment: Alignment.center,
              child: Text(
                "المجموع",
                style: TextStyle(
                  color: PdfColor.fromHex("#FFFFFF"),
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
