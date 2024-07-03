import 'package:mmtransport/Data/data.decoder.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';

class TablesLocal {
  static Future<StatusRequest> getTables() async {
    final db = await AppDatabase.database;
    final query = await db.query("Tables");
    final tables = CustomDataDecoder.tablesResponceDataDecoder(query);
    return StatusRequest(connectionStatus: ConnectionStatus.success, data: tables);
  }

  static Future<TableEntity?> getTableById(int? id, int? tableId) async {
    final db = await AppDatabase.database;
    List query = [];

    if (id != null) {
      query = await db.query("Tables", where: "id = ?", whereArgs: [id]);
    }

    if (tableId != null) {
      query = await db.query("Tables", where: "tableId = ?", whereArgs: [tableId]);
    }

    if (query.isNotEmpty) return TableEntity.fromJson(query.first);
    return null;
  }

  static Future<StatusRequest> createNewTable(TableEntity table) async {
    final db = await AppDatabase.database;
    int id = await db.insert("Tables", table.toMap());
    table.id = id;
    return StatusRequest(connectionStatus: ConnectionStatus.success, data: table);
  }

  static Future<int> deleteTableById(int id) async {
    final db = await AppDatabase.database;
    return await db.delete("Tables", where: "id = ?", whereArgs: [id]);
  }

  static Future<int> deleteTableByTableId(int tableId) async {
    final db = await AppDatabase.database;
    return await db.delete("Tables", where: "tableId = ?", whereArgs: [tableId]);
  }

  static Future<int> updateTable(TableEntity tableEntity) async {
    final db = await AppDatabase.database;
    int result = 0;

    if (tableEntity.id != null) {
      result = await db.update(
        "Tables",
        tableEntity.toMapWithNoId(),
        where: "id = ?",
        whereArgs: [tableEntity.id],
      );
    } else if (tableEntity.tableId != null) {
      result = await db.update(
        "Tables",
        tableEntity.toMapWithNoId(),
        where: "tableId = ?",
        whereArgs: [tableEntity.tableId],
      );
    }
    return result;
  }
}
