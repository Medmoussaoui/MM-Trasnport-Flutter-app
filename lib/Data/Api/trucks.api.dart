import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.api.dart';
import 'package:mmtransport/Functions/access_token.dart';
import 'package:mmtransport/Functions/handling_api_responce.dart';
import 'package:mmtransport/class/api_connection.dart';

class TruckApi extends GetConnect {
  Future<StatusRequest> getTrucks() async {
    String accessToken = await getAccessToken();
    Response res = await get(
      AppApiLinks.trucks.getTrucks,
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }
}
