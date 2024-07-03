import 'package:mmtransport/Data/entitys/service_entity.dart';

class TableEntity {
  int? id;
  int? tableId;
  String? tableName;
  String? boats;
  String? lastEdit;
  String? dateCreate;
  List<ServiceEntity>? service;

  TableEntity({
    this.id,
    this.tableName,
    this.tableId,
    this.lastEdit,
    this.service,
    this.boats,
    this.dateCreate,
  });

  factory TableEntity.fromJson(dynamic data) {
    return TableEntity(
      id: data["id"],
      tableId: data["tableId"],
      tableName: data["tableName"],
      lastEdit: data["lastEdit"],
      dateCreate: data["dateCreate"],
      boats: data["boats"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "tableId": tableId,
      "tableName": tableName,
      "boats": boats,
      "lastEdit": lastEdit,
      "dateCreate": dateCreate,
    };
  }

  Map<String, dynamic> toMapWithNoId() {
    return {
      "tableId": tableId,
      "tableName": tableName,
      "boats": boats,
      "lastEdit": lastEdit,
      "dateCreate": dateCreate,
    };
  }
}
