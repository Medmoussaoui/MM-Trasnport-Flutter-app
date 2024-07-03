import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/Functions/is_paying_off.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class InvoiceTableRow {
  final ServiceEntity service;

  InvoiceTableRow(this.service);

  Widget build() {
    List<String> values = _toValues(service);
    bool isPayingOff = isPayingOffServiceType(service.serviceType!);

    return Row(
      children: [
        Expanded(
          child: _rowItem(
            values[0],
            isInactive: service.isInactive,
            isPaingOff: isPayingOff,
          ),
        ),
        Expanded(
          child: _rowItem(
            values[1],
            isInactive: service.isInactive,
            isPaingOff: isPayingOff,
          ),
        ),
        Expanded(
          child: _rowItem(
            values[2],
            isInactive: service.isInactive,
            isPaingOff: isPayingOff,
          ),
        ),
        Expanded(
          child: _rowItem(
            values[3],
            isInactive: service.isInactive,
            isPaingOff: isPayingOff,
          ),
        ),
        Expanded(
          child: _rowItem(
            values[4],
            isInactive: service.isInactive,
            isPaingOff: isPayingOff,
          ),
        ),
      ],
    );
  }

  PdfColor _color(bool? isPaingOff, bool? isInactive) {
    if (isPaingOff == true) return PdfColor.fromHex("#FF0000");
    if (isInactive == true) return PdfColor.fromHex("#7E7E7E");
    return PdfColor.fromHex("#000000");
  }

  _rowItem(String value, {bool? isPaingOff, bool? isInactive}) {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
      decoration: BoxDecoration(
        color: PdfColor.fromHex("#F9F9F9"),
        border: Border.all(color: PdfColor.fromHex("#323232"), width: 0.4),
      ),
      child: value.isNotEmpty
          ? FittedBox(
              alignment: Alignment.center,
              child: Text(
                value,
                style: TextStyle(
                  decoration: isInactive == true ? TextDecoration.lineThrough : TextDecoration.none,
                  color: _color(isPaingOff, isInactive),
                  fontSize: 20.0,
                ),
              ),
            )
          : null,
    );
  }

  List<String> _toValues(ServiceEntity service) {
    String note = service.note ?? "";
    return [
      getDateAndTime(service.dateCreate!),
      note,
      service.price!.toInt().toString(),
      service.serviceType!,
      service.boatName!,
    ];
  }
}
