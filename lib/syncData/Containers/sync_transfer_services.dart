import 'package:mmtransport/Data/local/tables.local.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/developer.dart';
import 'package:mmtransport/syncData/model.dart';

import '../../Data/Api/services.api.dart';

class SyncTransferServices extends SyncContainer {
  SyncTransferServices() : super(storeContainer);
  @override
  Future<void> forse(item) async {}

  static final storeContainer = SyncTableScheama(
    tableName: "SyncTransferNewServices",
    columns: [
      SyncTableColumn(
        columnName: "serviceId",
        dataType: TableColumnDataType.integer,
      ),
      SyncTableColumn(
        columnName: "tableId",
        dataType: TableColumnDataType.integer,
      ),
    ],
  );

  static Future<void> addToSync(int serviceId, int to) async {
    await storeContainer.initial();
    await storeContainer.insert({"serviceId": serviceId, "tableId": to});
  }

  @override
  Future<StatusRequest> request(item) async {
    int serviceId = item["serviceId"];
    int to = item["tableId"];
    if (to < 0) {
      final table = await TablesLocal.getTableById(to.abs(), null);
      if (table == null) return StatusRequest().success();
      to = table.tableId ?? to;
    }
    if (to < 0) return StatusRequest().respondError();
    return ServicesApi().customTransfer([serviceId], to);
  }

  @override
  Future<void> onStart() async {
    CustomPrint.printGreenText("- [start] Sync Transfer New Services");
    super.onStart();
  }

  @override
  Future<void> onEnd() {
    CustomPrint.printGreenText("- [End] Sync Transfer New Services");
    return super.onEnd();
  }
}
