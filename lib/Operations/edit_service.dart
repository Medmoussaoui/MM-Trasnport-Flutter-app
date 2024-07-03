import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/local/services.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/Functions/find_truck_by_number_locally.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/syncData/Containers/sync_edit_services.dart';

class EditService {
  final ServiceEntity newService;

  EditService(this.newService);

  Future<void> editOffline() async {
    if (newService.id != null) {
      await ServicesLocal.editServiceById(newService);
      return;
    }
    if (newService.serviceId != null) {
      await ServicesLocal.editServiceByServiceId(newService);
    }
  }

  Future<StatusRequest> editOnline() async {
    return ServicesApi().editService(newService);
  }

  Future<void> sendToSyncProcess() async {
    if (newService.serviceId != null) {
      SyncEditServices.addToSync(newService.serviceId);
    }
  }

  Future<StatusRequest> edit() async {
    bool hasConnection = await hasInternet();
    if (hasConnection) {
      StatusRequest responce = await editOnline();
      if (responce.isSuccess) {
        await editOffline();
        return responce;
      }
      if (!responce.isConnectionError) return responce;
    }

    bool isFound = await findTruckByNumberLocally(newService.truckNumber ?? "");
    if (isFound) {
      await editOffline();
      await sendToSyncProcess();
      return StatusRequest().success();
    }

    return StatusRequest().connectionError();
  }
}
