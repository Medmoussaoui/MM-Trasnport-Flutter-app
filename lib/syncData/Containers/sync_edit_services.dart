import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

class SyncEditServices extends SyncContainer {
  SyncEditServices() : super(storeContainer);

  @override
  Future<void> forse(item) async {}

  static final storeContainer = SyncTableScheama(
    tableName: "SyncEditServices",
    columns: [
      SyncTableColumn(
        columnName: "serviceId",
        dataType: TableColumnDataType.integer,
      ),
    ],
  );

  static Future<void> addToSync(int? serviceId) async {
    await storeContainer.initial();
    await storeContainer.insert({"serviceId": serviceId});
  }

  @override
  Future<StatusRequest> request(item) async {
    int serviceId = item["serviceId"];
    ServiceEntity? service = await ServicesLocal.getServiceByServiceId(serviceId);
    if (service == null) return StatusRequest().success();
    return await ServicesApi().editService(service);
  }

  @override
  Future<void> onStart() async {
    CustomPrint.printGreenText("- [start] Sync Edit Service");
    super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync Edit Servces");
    return super.onEnd();
  }
}
