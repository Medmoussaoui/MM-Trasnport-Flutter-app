import 'package:mmtransport/Data/data.decoder.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/is_paying_off.dart';

class Invoice {
  int? invoiceId;
  int? tableId;
  String? invoiceName;
  int? totalSummation;
  int? totalPayingOff;
  int? finalTotal;
  String? payStatus;
  String? padiDate;
  String? dateCreate;
  int? save;
  bool? inactive;
  List<ServiceEntity>? services;

  Invoice({
    this.invoiceId,
    this.tableId,
    this.invoiceName,
    this.totalSummation,
    this.totalPayingOff,
    this.finalTotal,
    this.payStatus,
    this.padiDate,
    this.dateCreate,
    this.save,
    this.services,
    this.inactive,
  });

  refrechAccounting() {
    totalPayingOff = 0;
    finalTotal = 0;
    totalSummation = 0;
    for (ServiceEntity service in services!) {
      if (service.isInactive != null && service.isInactive == true) continue;
      if (isPayingOffServiceType(service.serviceType!)) {
        totalPayingOff = totalPayingOff! + service.price!.toInt();
        continue;
      }
      totalSummation = totalSummation! + service.price!.toInt();
    }
    finalTotal = totalSummation! - totalPayingOff!;
  }

  factory Invoice.fromJeson(dynamic data) {
    return Invoice(
      invoiceId: data["invoiceId"],
      tableId: data["tableId"],
      invoiceName: data["invoiceName"],
      totalSummation: data["totalSummation"],
      totalPayingOff: data["totalPayingOff"],
      finalTotal: data["finalTotal"],
      payStatus: data["pay_status"],
      padiDate: data["padiDate"],
      dateCreate: data["dateCreate"],
      save: data["save"],
      inactive: data["inactive"],
      services: CustomDataDecoder.serviceDecoder(data["services"]),
    );
  }
}

class TableInvoices {
  int? tableId;
  String? tableName;
  List<Invoice> invoices;

  TableInvoices({this.tableId, this.tableName, this.invoices = const []});

  factory TableInvoices.fromJson(dynamic data) {
    return TableInvoices(
      tableId: data["tableId"],
      tableName: data["tableName"],
      invoices: CustomDataDecoder.invoicesDecoder(data["invoices"]),
    );
  }
}
