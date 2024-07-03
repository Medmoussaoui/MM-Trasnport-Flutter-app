import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

class SyncDeleteServices extends SyncContainer {
  SyncDeleteServices() : super(storeContainer);

  @override
  Future<void> forse(item) async {}

  static SyncTableScheama storeContainer = SyncTableScheama(
    tableName: "SyncDeleteServices",
    columns: [
      SyncTableColumn(
        columnName: "serviceId",
        dataType: TableColumnDataType.integer,
      ),
    ],
  );

  static Future<void> addToSync(List<int> serviceIds) async {
    await storeContainer.initial();
    for (int serviceId in serviceIds) {
      await storeContainer.insert({"serviceId": serviceId});
    }
  }

  @override
  Future<void> dropItem(item) async {
    await store.clear();
    storeData = [];
  }

  @override
  Future<void> initialStore() async {
    await store.initial();
    final query = await store.query();
    storeData = query.isNotEmpty ? [query] : [];
  }

  List<int> getServiceIds(List items) {
    List<int> serviceIds = [];
    for (var item in items) {
      serviceIds.add(item["serviceId"]);
    }
    return serviceIds;
  }

  @override
  Future<StatusRequest> request(item) async {
    List<int> serviceIds = getServiceIds(item);
    return await ServicesApi().removeServices(serviceIds);
  }

  @override
  Future<void> onStart() {
    CustomPrint.printGreenText("- [start] Sync Delete Services");
    return super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync Delete Servces");
    return super.onEnd();
  }
}
