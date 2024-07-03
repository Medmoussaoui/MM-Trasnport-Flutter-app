import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

import '../../Data/Api/tables.api.dart';
import '../../Data/entitys/table.entity.dart';
import '../../Data/local/tables.local.dart';

class SyncRenameTables extends SyncContainer {
  SyncRenameTables() : super(storeContainer);

  @override
  Future<void> forse(item) async {}

  static final storeContainer = SyncTableScheama(
    tableName: "SyncRenameTables",
    columns: [
      SyncTableColumn(
        columnName: "tableId",
        dataType: TableColumnDataType.integer,
      ),
      SyncTableColumn(
        columnName: "tableName",
        dataType: TableColumnDataType.text,
      ),
    ],
  );

  static Future<void> addToSync(int? tableId, String newTableName) async {
    await storeContainer.initial();
    await storeContainer.insert({
      "tableId": tableId,
      "tableName": newTableName,
    });
  }

  @override
  Future<StatusRequest> request(item) async {
    int tableId = item["tableId"];
    String tableName = item["tableName"];
    TableEntity? table = await TablesLocal.getTableById(null, tableId);
    if (table == null) return StatusRequest().success();
    return await TablesApi().renameTable(tableName, tableId);
  }

  @override
  Future<void> onStart() async {
    CustomPrint.printGreenText("- [start] Sync Rename Tables");
    super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync Rename Tables");
    return super.onEnd();
  }
}
