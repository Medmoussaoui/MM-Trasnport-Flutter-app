import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Data/local/tables.local.dart';
import 'package:mmtransport/Functions/generate_sync_ref_id.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

class SyncAddNewTableServices extends SyncContainer {
  SyncAddNewTableServices() : super(storeContainer);

  @override
  Future<void> forse(item) async {
    final db = await AppDatabase.database;
    await db.delete("Services", where: "id = ?", whereArgs: [item["id"]]);
  }

  static final storeContainer = SyncTableScheama(
    tableName: "SyncAddNewTableServices",
    columns: [
      SyncTableColumn(
        columnName: "id",
        dataType: TableColumnDataType.integer,
      ),
      SyncTableColumn(
        columnName: "tableId",
        dataType: TableColumnDataType.integer,
      ),
    ],
  );

  static Future<void> addToSync(int id, int tableId, {String? requestId}) async {
    await storeContainer.initial();
    await storeContainer.insert({"id": id, "tableId": tableId, "requestId": requestId});
  }

  bool isTableIdNegative(int tableId) => (tableId < 0);

  Future<void> updateLocaleService(ServiceEntity newService, int id) async {
    newService.id = id;
    await ServicesLocal.editServiceById(newService);
  }

  String syncRefId(int ref) {
    return generateSyncRefId(storeContainer.tableName, ref);
  }

  removeLoacleSerice(int id) async {
    final db = await AppDatabase.database;
    await db.delete("Services", where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<StatusRequest> request(item) async {
    int tableId = item['tableId'];
    int id = item['id'];
    String requestId = item["requestId"] ?? syncRefId(item['ref']);

    if (isTableIdNegative(tableId)) {
      TableEntity? table = await TablesLocal.getTableById(tableId.abs(), null);

      if (table == null) {
        await ServicesLocal.removeServiceById(id);
        return StatusRequest().success();
      }

      if (isTableIdNegative(table.tableId!)) {
        return StatusRequest().connectionError();
      }

      tableId = table.tableId!;
    }

    ServiceEntity? service = await ServicesLocal.getServiceById(id);

    if (service == null) {
      return StatusRequest().success();
    }

    service.tableId = tableId;

    StatusRequest res = await ServicesApi().addService(service, requestId: requestId);
    if (res.isSuccess) {
      if (res.data == "This is Aready synced") {
        await removeLoacleSerice(id);
        return res;
      }
      await updateLocaleService(res.data, id);
    }
    return res;
  }

  @override
  Future<void> onStart() async {
    CustomPrint.printGreenText("- [start] Sync Add New Table Services");
    super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync Sync Add New Table Services");
    return super.onEnd();
  }
}
