import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/Functions/find_truck_by_number_locally.dart';
import 'package:mmtransport/Functions/generate_unique_request_id.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_add_new_services.dart';
import 'package:mmtransport/syncData/Containers/sync_new_table_services.dart';

class CreateService {
  Future<StatusRequest> createServiceOffline(ServiceEntity service) async {
    ServiceEntity add = await ServicesLocal.addService(service);
    return StatusRequest(connectionStatus: ConnectionStatus.success, data: add);
  }

  Future<StatusRequest> createServiceOnline(ServiceEntity service, String requestId) async {
    return await ServicesApi().addService(service, requestId: requestId);
  }

  Future<void> sendToSyncProcess(ServiceEntity service, String requestId) async {
    if (service.tableId == null) {
      return await SyncAddNewService.addToSync(service.id!, requestId);
    }
    await SyncAddNewTableServices.addToSync(
      service.id!,
      service.tableId!,
      requestId: requestId,
    );
  }

  Future<StatusRequest> create(ServiceEntity service) async {
    StatusRequest res = StatusRequest();
    final hasConnection = await hasInternet();
    String requestId = generateUniqueRequestId();
    if (hasConnection) {
      res = await createServiceOnline(service, requestId);
      if (res.isSuccess) {
        return await createServiceOffline(res.data);
      }
      if (!res.isConnectionError) return res;
    }

    bool isFound = await findTruckByNumberLocally(service.truckNumber!);
    if (isFound) {
      final res = await createServiceOffline(service);
      await sendToSyncProcess(res.data, requestId);
      return StatusRequest().success();
    }
    return StatusRequest().connectionError();
  }
}
