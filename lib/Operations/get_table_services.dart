import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Functions/to_values.dart';
import 'package:mmtransport/Operations/refrecher.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_edit_services.dart';

class GetTableServices {
  TableEntity table;

  GetTableServices(this.table);

  Future<StatusRequest> getDataLocally() async {
    return await ServicesLocal.getTableServices(table.tableId, table.id);
  }

  Future<StatusRequest> getDataRemotly() async {
    if (table.tableId == null) return getDataLocally();
    final res = await ServicesApi().getTableServices(table.tableId!);
    if (res.isSuccess) {
      await RefrechNewTableServices(table).refrech(res.data);
      return await getDataLocally();
    }
    return res;
  }
}

class RefrechNewTableServices extends RefrecherData<ServiceEntity> {
  TableEntity table;

  RefrechNewTableServices(this.table);
  @override
  Future<void> clearLocale() async {
    await db.delete(
      "Services",
      where: "tableId = ? AND serviceId NOT NULL",
      whereArgs: [table.tableId],
    );
    return;
  }

  @override
  Future<List<ServiceEntity>> getImportantItems() async {
    final store = await SyncEditServices.storeContainer.initial();
    final query = await store.query();
    List serviceIds = query.map((e) => e["serviceId"]).toList();
    List services = await db.query(
      "Services",
      where: "serviceId IN(${toValues(serviceIds)}) AND tableId = ?",
      whereArgs: [table.tableId],
    );
    return services.map((item) => ServiceEntity.fromJson(item)).toList();
  }

  @override
  Future<List<ServiceEntity>> getItems() async {
    return [];
  }

  @override
  Future insert(ServiceEntity item) async {
    return db.insert("Services", item.toMapWithNoId());
  }
}
