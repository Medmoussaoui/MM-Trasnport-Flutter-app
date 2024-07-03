import 'package:get/get.dart';
import 'package:mmtransport/class/api_connection.dart';

StatusRequest handleApiResponce(Response responce) {
  final StatusRequest statusRequest = StatusRequest(
    data: responce.body ?? [],
    headers: responce.headers,
  );
  if (responce.status.connectionError) {
    return statusRequest.connectionError();
  }

  if (responce.hasError) {
    return statusRequest.respondError();
  }

  if (responce.statusCode! >= 500) {
    return statusRequest.serverFailer();
  }

  return statusRequest.success();
}
