import 'package:mmtransport/Data/Api/tables.api.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/tables.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/Functions/to_values.dart';
import 'package:mmtransport/Operations/refrecher.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';
import 'package:mmtransport/class/local_data_refrecher.dart';

class GetTablesController {
  Future<StatusRequest> getTablesRemotly() async {
    return await TablesApi().getTables();
  }

  Future<StatusRequest> getTablesLocally() async {
    return await TablesLocal.getTables();
  }

  Future<StatusRequest> getTables() async {
    bool hasConnection = await hasInternet();
    StatusRequest res;
    if (hasConnection) {
      res = await getTablesRemotly();
      if (res.isSuccess) {
        await TestRefrechTables().refrech(res.data);
        return getTablesLocally();
      }
      if (!res.isConnectionError) return res;
    }
    res = await getTablesLocally();
    return res;
  }
}

class RefrechTables extends RefrechSmart<TableEntity> {
  @override
  Future<void> delete(List matchedData) async {
    final db = await AppDatabase.database;
    String matched = toValues(matchedData);

    // delete all table dosn't exist remotly anymore
    await db.delete(
      "Tables",
      where: "tableId NOT IN($matched) AND tableId IS NOT NULL",
    );

    // delete all services that its table dosn't exist anymore
    await db.delete(
      "Services",
      where: "tableId NOT IN($matched) AND tableId IS NOT NULL AND tableId > 0",
    );
  }

  @override
  Future<int> insert(TableEntity item) async {
    final db = await AppDatabase.database;
    return await db.insert("Tables", item.toMapWithNoId());
  }

  @override
  Future<bool> isNeedSync(TableEntity item) async {
    return false;
  }

  @override
  Future<String> onMatched(TableEntity item) async {
    return "${item.tableId}";
  }

  @override
  Future<int> update(TableEntity item) async {
    final db = await AppDatabase.database;
    return await db.update(
      "Tables",
      item.toMapWithNoId(),
      where: "tableId = ?",
      whereArgs: [item.tableId],
    );
  }
}

///
///
///
///
///
class TestRefrechTables extends RefrecherData<TableEntity> {
  @override
  Future<void> clearLocale() async {
    await db.delete("Tables", where: "tableId IS NOT NULL");
  }

  @override
  Future<List<TableEntity>> getImportantItems() async {
    return [];
  }

  @override
  Future<List<TableEntity>> getItems() async {
    return [];
  }

  @override
  Future insert(TableEntity item) async {
    await db.insert("Tables", item.toMapWithNoId());
  }
}
