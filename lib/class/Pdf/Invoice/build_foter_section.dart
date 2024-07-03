import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class InvoiceFoterSection {
  Widget build() {
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(color: PdfColor.fromHex("#7E7E7E")),
          ),
          Text(
            "يمكنك مسح رمز الفاتورة من التطبيق لتاكد من صحت الفاتورة",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "+212 668 400 817",
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 10),
              Text(
                "لتواصل و الاستفسار",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
