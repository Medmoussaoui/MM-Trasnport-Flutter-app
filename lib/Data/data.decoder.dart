import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';

class CustomDataDecoder {
  static List<ServiceEntity> serviceDecoder(dynamic data) {
    return (data as List).map<ServiceEntity>((service) => ServiceEntity.fromJson(service)).toList();
  }

  static List<TableEntity> tablesResponceDataDecoder(dynamic data) {
    return (data as List).map((table) => TableEntity.fromJson(table)).toList();
  }

  static List<Invoice> invoicesDecoder(dynamic data) {
    return (data as List).map((invoice) => Invoice.fromJeson(invoice)).toList();
  }
}
