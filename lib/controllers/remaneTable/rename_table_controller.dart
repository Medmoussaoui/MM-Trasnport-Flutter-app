import 'package:mmtransport/Data/Api/tables.api.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/tables.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_rename_tables.dart';

class RenameTableController {
  final TableEntity table;

  RenameTableController(this.table);

  Future<StatusRequest> renameOffline() async {
    await TablesLocal.updateTable(table);
    return StatusRequest().success();
  }

  Future<StatusRequest> renameOnline() async {
    return await TablesApi().renameTable(table.tableName!, table.tableId!);
  }

  Future<void> sendToSyncProcess(TableEntity table) async {
    await SyncRenameTables.addToSync(table.tableId, table.tableName!);
  }

  bool hasTableId() {
    if (table.tableId != null) return table.tableId! > 0;
    return false;
  }

  Future<StatusRequest> rename() async {
    bool hasConnection = await hasInternet();
    if (hasTableId()) {
      if (hasConnection) {
        final res = await renameOnline();
        if (res.isSuccess) return await renameOffline();
        if (!res.isConnectionError) return res;
      }
    }
    await renameOffline();
    if (hasTableId()) await sendToSyncProcess(table);
    return StatusRequest().success();
  }
}
