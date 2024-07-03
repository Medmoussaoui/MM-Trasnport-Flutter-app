import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class InvoicePaymentStatus {
  final Invoice invoice;

  InvoicePaymentStatus(this.invoice);

  String _padiDate() {
    if (isPaid && invoice.padiDate != null) return "(${getDate(invoice.padiDate!)})";
    return "";
  }

  String _paymentStatus() {
    if (isPaid) return "مدفوعة";
    return "غير مدفوعة";
  }

  bool _isPaid() => invoice.payStatus == "paid";
  late bool isPaid;
  Widget build() {
    isPaid = _isPaid();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      child: Row(
        children: [
          Spacer(),
          Text(
            _padiDate(),
            style: TextStyle(
              fontSize: 17.0,
              color: PdfColor.fromHex("#7E7E7E"),
            ),
          ),
          SizedBox(width: 10),
          Text(
            _paymentStatus(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: isPaid ? PdfColor.fromHex("#008FFE") : PdfColor.fromHex("#FE6F00"),
            ),
          ),
          SizedBox(width: 10),
          Text(
            "حالة الفاتورة",
            style: TextStyle(
              fontSize: 17.0,
              color: PdfColor.fromHex("#000000"),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
