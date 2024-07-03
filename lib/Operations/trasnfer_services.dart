import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_add_new_services.dart';
import 'package:mmtransport/syncData/Containers/sync_new_table_services.dart';
import 'package:mmtransport/syncData/Containers/sync_transfer_services.dart';

class TransferNewServices {
  final TableEntity table;

  /// services we need to transfer
  ///
  final List<ServiceEntity> services;

  TransferNewServices(this.table, this.services);

  int _to() {
    return table.tableId ?? -table.id!;
  }

  int get to => _to();

  Future<void> updateServiceTableId(ServiceEntity service) async {
    service.tableId = to;
    await ServicesLocal.editServiceById(service);
  }

  Future<StatusRequest> transferOnline(List<int> serviceIds) async {
    return await ServicesApi().customTransfer(serviceIds, to);
  }

  Future<void> sendToSyncProcess(List<int> serviceIds) async {
    for (final serviceId in serviceIds) {
      await SyncTransferServices.addToSync(serviceId, to);
    }
  }

  dropNewServiceFromSyncProcess(int id) async {
    final store = await SyncAddNewService.storeContainer.initial();
    await store.deleteWhere("id = ?", [id]);
  }

  addServiceToSyncAddTableServiceProcess(int id) async {
    await SyncAddNewTableServices.addToSync(id, to);
  }

  changeServiceSyncInstance(int id) async {
    await dropNewServiceFromSyncProcess(id);
    await addServiceToSyncAddTableServiceProcess(id);
  }

  Future<bool> transfer() async {
    List<int> onlineService = [];
    for (final service in services) {
      await updateServiceTableId(service);
      if (service.serviceId == null) {
        await changeServiceSyncInstance(service.id!);
        continue;
      }
      onlineService.add(service.serviceId!);
    }

    if (onlineService.isEmpty) return true;

    bool hasConnection = await hasInternet();

    if (hasConnection) {
      StatusRequest res = await transferOnline(onlineService);
      if (res.isSuccess) return true;
      if (!res.isConnectionError) return false;
    }

    await sendToSyncProcess(onlineService);
    return true;
  }
}

class TransferTableServices {
  final TableEntity table;
  final List<ServiceEntity> services;

  TransferTableServices(this.table, this.services);

  int _to() {
    return table.tableId ?? -table.id!;
  }

  int get to => _to();

  Future<void> updateServiceTableId(ServiceEntity service) async {
    service.tableId = to;
    await ServicesLocal.editServiceById(service);
  }

  Future<StatusRequest> transferOnline(List<ServiceEntity> items) async {
    List<int> serviceIds = items.map<int>((e) => e.serviceId!).toList();
    return await ServicesApi().customTransfer(serviceIds, to);
  }

  Future<void> sendToSyncProcess(List<ServiceEntity> items) async {
    for (final item in items) {
      await SyncTransferServices.addToSync(item.serviceId!, to);
    }
  }

  Future<bool> transfer() async {
    List<ServiceEntity> onlineService = [];
    final store = await SyncAddNewTableServices.storeContainer.initial();
    for (final service in services) {
      await updateServiceTableId(service);
      if (service.serviceId == null) {
        await store.update({"tableId": to}, "id = ?", [service.id]);
        continue;
      }
      onlineService.add(service);
    }

    if (onlineService.isEmpty) return true;

    bool hasConnection = await hasInternet();

    if (hasConnection) {
      StatusRequest res = await transferOnline(onlineService);
      if (res.isSuccess) return true;
      if (!res.isConnectionError) return false;
    }

    await sendToSyncProcess(onlineService);
    return true;
  }
}
