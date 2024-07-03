import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Functions/to_values.dart';
import 'package:mmtransport/Operations/refrecher.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_edit_services.dart';

class GetNewServices {
  Future<StatusRequest> getDataLocally() async {
    return await ServicesLocal.geNewServices();
  }

  Future<StatusRequest> getDataRemotly() async {
    final res = await ServicesApi().getNewServices();
    if (res.isSuccess) {
      await RefrechNewItems().refrech(res.data);
      return await getDataLocally();
    }
    return res;
  }
}

class RefrechNewItems extends RefrecherData<ServiceEntity> {
  @override
  Future<void> clearLocale() async {
    await db.delete("Services", where: "tableId IS NULL AND serviceId NOT NULL");
    return;
  }

  @override
  Future<List<ServiceEntity>> getImportantItems() async {
    final store = await SyncEditServices.storeContainer.initial();
    final query = await store.query();
    List serviceIds = query.map((e) => e["serviceId"]).toList();
    List services = await db.query("Services", where: "serviceId IN(${toValues(serviceIds)}) AND tableId IS NULL");
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
