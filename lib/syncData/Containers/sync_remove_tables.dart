import 'package:mmtransport/Data/Api/tables.api.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

class SyncRemoveTables extends SyncContainer {
  SyncRemoveTables() : super(storeContainer);

  @override
  Future<void> forse(item) async {}

  static final storeContainer = SyncTableScheama(
    tableName: "SyncRemoveTables",
    columns: [
      SyncTableColumn(
        columnName: "tableId",
        dataType: TableColumnDataType.integer,
      ),
    ],
  );

  static Future<void> addToSync(int? tableId) async {
    await storeContainer.initial();
    await storeContainer.insert({"tableId": tableId});
  }

  @override
  Future<StatusRequest> request(item) async {
    int tableId = item["tableId"];
    return await TablesApi().removeTable(tableId);
  }

  @override
  Future<void> onStart() async {
    CustomPrint.printGreenText("- [start] Sync Remove Tables");
    super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync Remove Tables");
    return super.onEnd();
  }
}
