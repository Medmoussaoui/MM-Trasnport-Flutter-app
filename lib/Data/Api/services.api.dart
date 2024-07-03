import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.api.dart';
import 'package:mmtransport/Data/data.decoder.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/transfer.entity.dart';
import 'package:mmtransport/Functions/access_token.dart';
import 'package:mmtransport/Functions/handling_api_responce.dart';
import 'package:mmtransport/class/api_connection.dart';

class ServicesApi extends GetConnect {
  Future<StatusRequest> getNewServices() async {
    String accessToken = await getAccessToken();
    final Response responce = await get(
      AppApiLinks.services.getServices,
      headers: {"access-token": accessToken},
    );
    final res = handleApiResponce(responce);
    if (res.isSuccess) res.data = CustomDataDecoder.serviceDecoder(res.data);
    return res;
  }

  Future<StatusRequest> getTableServices(int tableId) async {
    String accessToken = await getAccessToken();
    final Response responce = await get(
      AppApiLinks.tables.getServices,
      headers: {
        "access-token": accessToken,
        "tableId": tableId.toString(),
      },
    );
    final res = handleApiResponce(responce);
    if (res.isSuccess) res.data = CustomDataDecoder.serviceDecoder(res.data);
    return res;
  }

  Future<StatusRequest> addService(ServiceEntity service, {String? requestId}) async {
    String accessToken = await getAccessToken();
    final headers = {"access-token": accessToken, "requestId": requestId!};

    final Response responce = await post(
      AppApiLinks.services.addService,
      {
        "boatName": service.boatName,
        "serviceType": service.serviceType,
        "price": service.price,
        "note": service.note,
        "truckNumber": service.truckNumber,
        "dateCreate": service.dateCreate,
        "pay_from": service.payFrom,
        "tableId": service.tableId,
      },
      headers: headers,
    );
    final res = handleApiResponce(responce);
    if (res.isSuccess) {
      if (res.data == 'This is Aready synced') return res;
      res.data = ServiceEntity.fromJson(res.data);
    }
    return res;
  }

  Future<StatusRequest> removeServices(List<int> serviceIds) async {
    String accessToken = await getAccessToken();
    final Response res = await post(
      AppApiLinks.services.deleteServices,
      {"serviceIds": serviceIds},
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }

  Future<StatusRequest> editService(ServiceEntity service) async {
    String accessToken = await getAccessToken();
    final res = await put(
      AppApiLinks.services.editService,
      service.toMapWithNoId(),
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }

  Future<StatusRequest> customTransfer(List<int> serviceIds, int to) async {
    String accessToken = await getAccessToken();
    final res = await post(
      AppApiLinks.services.customTransfer,
      {
        "serviceIds": serviceIds,
        "to": to,
      },
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }

  Future<StatusRequest> autoTransfer() async {
    String accessToken = await getAccessToken();
    final responce = await post(
      AppApiLinks.services.autoTransfer,
      {},
      headers: {"access-token": accessToken},
    );
    final res = handleApiResponce(responce);
    if (res.isSuccess) res.data = TransferResult.fromJson(res.data);
    return res;
  }
}
