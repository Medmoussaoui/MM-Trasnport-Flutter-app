import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class InvoiceTableColumns {
  Widget build() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: PdfColor.fromHex("#000000"),
        border: Border.all(color: PdfColor.fromHex("#323232")),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: _columnValue("التاريخ")),
          Expanded(child: _columnValue("الملاحضة")),
          Expanded(child: _columnValue("الثمن")),
          Expanded(child: _columnValue("البضاعة")),
          Expanded(child: _columnValue("القارب")),
        ],
      ),
    );
  }

  Widget _columnValue(String value) {
    return Padding(
      padding: const EdgeInsets.all(11),
      child: FittedBox(
        alignment: Alignment.center,
        child: Text(
          value,
          style: TextStyle(
            color: PdfColor.fromHex("#FFFFFF"),
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
