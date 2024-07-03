import 'package:mmtransport/Data/Api/tables.api.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/tables.local.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

class SyncCreateTables extends SyncContainer {
  SyncCreateTables() : super(storeContainer);

  @override
  Future<void> forse(item) async {
    final db = await AppDatabase.database;
    await db.delete("Tables", where: "id = ?", whereArgs: [item["id"]]);
  }

  static final storeContainer = SyncTableScheama(
    tableName: "SyncCreateNewTables",
    columns: [
      SyncTableColumn(
        columnName: "id",
        dataType: TableColumnDataType.integer,
      ),
    ],
  );

  static Future<void> addToSync(int id) async {
    await storeContainer.initial();
    await storeContainer.insert({"id": id});
  }

  Future<void> updateLocaleTable(TableEntity newTable, int id) async {
    newTable.id = id;
    await TablesLocal.updateTable(newTable);
  }

  @override
  Future<StatusRequest> request(item) async {
    int id = item["id"];

    TableEntity? table = await TablesLocal.getTableById(id, null);

    if (table == null) {
      return StatusRequest().success();
    }

    StatusRequest res = await TablesApi().createNewTable(table.tableName!);
    if (res.isSuccess) {
      await updateLocaleTable(res.data, id);
    }

    return res;
  }

  @override
  Future<void> onStart() async {
    CustomPrint.printGreenText("- [start] Sync Create Tables");
    super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync Create Tables");
    return super.onEnd();
  }
}
