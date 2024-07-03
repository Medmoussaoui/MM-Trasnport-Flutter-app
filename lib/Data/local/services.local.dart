import 'package:mmtransport/Data/data.decoder.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';

class ServicesLocal {
  static Future<StatusRequest> geNewServices() async {
    final db = await AppDatabase.database;
    final query = await db.rawQuery("SELECT * FROM Services WHERE tableId IS NULL ORDER BY datetime(dateCreate) DESC , serviceId DESC");
    return StatusRequest(
      connectionStatus: ConnectionStatus.success,
      data: CustomDataDecoder.serviceDecoder(query),
    );
  }

  static Future<StatusRequest> getTableServices(int? tableId, int? id) async {
    final db = await AppDatabase.database;
    final tableID = tableId ?? -id!;
    final query = await db.rawQuery(
      'SELECT * FROM "Services" WHERE "tableId" = ? ORDER BY datetime(dateCreate) DESC , serviceId DESC',
      [tableID],
    );
    return StatusRequest(
      connectionStatus: ConnectionStatus.success,
      data: CustomDataDecoder.serviceDecoder(query),
    );
  }

  static Future<ServiceEntity> addService(ServiceEntity service) async {
    final db = await AppDatabase.database;
    int id = await db.insert("Services", service.toMap());
    service.id = id;
    return service;
  }

  static Future<StatusRequest> removeServiceById(int? id) async {
    final db = await AppDatabase.database;
    await db.delete("Services", where: "id = ?", whereArgs: [id]);
    return StatusRequest(connectionStatus: ConnectionStatus.success);
  }

  static Future<StatusRequest> removeServiceByServiceId(int serviceId) async {
    final db = await AppDatabase.database;
    await db.delete("Services", where: "serviceId = ?", whereArgs: [serviceId]);
    return StatusRequest(connectionStatus: ConnectionStatus.success);
  }

  static Future<StatusRequest> editServiceById(ServiceEntity service) async {
    final db = await AppDatabase.database;
    await db.update(
      "Services",
      service.toMapWithNoId(),
      where: "id = ?",
      whereArgs: [service.id],
    );
    return StatusRequest(connectionStatus: ConnectionStatus.success);
  }

  static Future<int> editServiceByServiceId(ServiceEntity service) async {
    final db = await AppDatabase.database;
    return await db.update(
      "Services",
      service.toMapWithNoId(),
      where: "serviceId = ?",
      whereArgs: [service.serviceId],
    );
  }

  static Future<ServiceEntity?> getServiceById(int id) async {
    final db = await AppDatabase.database;
    final query = await db.query("Services", where: "id = ?", whereArgs: [id]);
    if (query.isNotEmpty) return ServiceEntity.fromJson(query.first);
    return null;
  }

  static Future<ServiceEntity?> getServiceByServiceId(int serviceId) async {
    final db = await AppDatabase.database;
    final query = await db.query("Services", where: "serviceId = ?", whereArgs: [serviceId]);
    if (query.isNotEmpty) return ServiceEntity.fromJson(query.first);
    return null;
  }
}
