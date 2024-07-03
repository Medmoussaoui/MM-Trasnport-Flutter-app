import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/Table/Controller/select_rows.dart';
import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_delete_services.dart';

class RemoveSelectedServices {
  final TableDataController controller;

  RemoveSelectedServices(this.controller);

  TableSelectRowsController get rowsController => controller.selectRowsController;

  List<int> serviceIds = [];
  List<int> ids = [];

  void initial() async {
    for (int index in rowsController.selectRows) {
      final service = controller.tableRowsData[index];
      if (service.serviceId != null) {
        serviceIds.add(service.serviceId!);
        continue;
      }
      ids.add(service.id!);
    }
  }

  Future<void> removeOffline() async {
    for (int id in ids) {
      await ServicesLocal.removeServiceById(id);
    }
    for (int serviceId in serviceIds) {
      await ServicesLocal.removeServiceByServiceId(serviceId);
    }
  }

  Future<StatusRequest> removeOnline() async {
    return ServicesApi().removeServices(serviceIds);
  }

  Future<void> sendToSyncProcess() async {
    await SyncDeleteServices.addToSync(serviceIds);
  }

  Future<bool> remove() async {
    initial();
    bool hasConnection = await hasInternet();
    if (hasConnection) {
      StatusRequest responce = await removeOnline();
      if (responce.isSuccess) {
        await removeOffline();
        return true;
      }
      if (!responce.isConnectionError) return false;
    }
    await removeOffline();
    await sendToSyncProcess();
    return true;
  }
}
