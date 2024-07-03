import 'package:mmtransport/Data/Api/tables.api.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/tables.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/syncData/Containers/sync_remove_tables.dart';

class RemoveTableController {
  final TableEntity table;

  RemoveTableController(this.table);

  Future removeTableOffline() async {
    await TablesLocal.deleteTableById(table.id!);
    removeTableService();
  }

  Future<StatusRequest> removeOnline() async {
    return await TablesApi().removeTable(table.tableId!);
  }

  Future<void> removeTableService() async {
    final db = await AppDatabase.database;
    if (table.tableId != null) {
      await db.delete("Services", where: "tableId = ?", whereArgs: [table.tableId]);
      return;
    }
    await db.delete("Services", where: "tableId = ?", whereArgs: [-table.id!]);
  }

  Future<void> sendToSyncProcess() async {
    if (table.tableId == null) return;
    await SyncRemoveTables.addToSync(table.tableId);
  }

  Future<bool> remove() async {
    bool hasConnection = await hasInternet();

    if (table.tableId == null || !hasConnection) {
      if (table.tableId != null) sendToSyncProcess();
      await removeTableOffline();
      return true;
    }

    final res = await removeOnline();

    if (res.isSuccess) {
      await removeTableOffline();
      return true;
    }

    if (!res.isConnectionError) {
      AppSnackBars.problemHappen();
      return false;
    }

    await Future.wait([sendToSyncProcess(), removeTableOffline()]);
    return true;
  }
}
