import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Functions/generate_sync_ref_id.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

class SyncAddNewService extends SyncContainer {
  SyncAddNewService() : super(storeContainer);

  @override
  Future<void> forse(item) async {
    final db = await AppDatabase.database;
    await db.delete("Services", where: "id = ?", whereArgs: [item["id"]]);
  }

  static SyncTableScheama storeContainer = SyncTableScheama(
    tableName: "SyncAddNewServices",
    columns: [
      SyncTableColumn(columnName: "id", dataType: TableColumnDataType.integer),
    ],
  );

  static Future<void> addToSync(int id, String requestId) async {
    await storeContainer.initial();
    await storeContainer.insert({"id": id, "requestId": requestId});
  }

  Future<void> updateLocaleService(ServiceEntity newService, int id) async {
    newService.id = id;
    await ServicesLocal.editServiceById(newService);
  }

  String? syncRefId(String ref) {
    return generateSyncRefId(storeContainer.tableName, ref);
  }

  removeLoacleSerice(int id) async {
    final db = await AppDatabase.database;
    await db.delete("Services", where: "id = ?", whereArgs: [id]);
  }

  @override
  Future<StatusRequest> request(item) async {
    int id = item['id'];
    ServiceEntity? service = await ServicesLocal.getServiceById(id);
    if (service == null) return StatusRequest().success();
    final requestId = item["requestId"] ?? syncRefId(item["ref"]);
    StatusRequest responce = await ServicesApi().addService(service, requestId: requestId);
    if (responce.isSuccess) {
      if (responce.data == "This is Aready synced") {
        await removeLoacleSerice(id);
        return responce;
      }
      await updateLocaleService(responce.data, id);
    }
    return responce;
  }

  @override
  Future<void> onStart() async {
    CustomPrint.printGreenText("- [start] Sync Add New Services");
    super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync  Add New Services");
    return super.onEnd();
  }
}
