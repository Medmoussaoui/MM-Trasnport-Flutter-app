import 'package:mmtransport/Data/Api/tables.api.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/tables.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_create_tables.dart';

class CreateTableController {
  Future<StatusRequest> createTableOffline(TableEntity table) async {
    return TablesLocal.createNewTable(table);
  }

  Future<StatusRequest> createTableOnline(String tableName) async {
    return TablesApi().createNewTable(tableName);
  }

  Future<void> addToSyncProcess(TableEntity table) async {
    await SyncCreateTables.addToSync(table.id!);
  }

  Future<StatusRequest> createTable(String tableName) async {
    bool hasConnection = await hasInternet();
    StatusRequest res = StatusRequest();

    if (hasConnection) {
      res = await createTableOnline(tableName);
      if (res.isSuccess) return await createTableOffline(res.data);
      if (!res.isConnectionError) return res;
    }

    String currentDate = DateTime.now().toString();
    res = await createTableOffline(TableEntity(
      tableName: tableName,
      boats: "",
      dateCreate: currentDate,
      lastEdit: currentDate,
    ));
    await addToSyncProcess(res.data);
    return res;
  }
}
