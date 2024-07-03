import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.api.dart';
import 'package:mmtransport/Functions/access_token.dart';
import 'package:mmtransport/Functions/handling_api_responce.dart';
import 'package:mmtransport/class/api_connection.dart';

class ServiceKeywordsApi extends GetConnect {
  Future<StatusRequest> getBoatNameKeywords(String keyword) async {
    String accessToken = await getAccessToken();
    final res = await get(
      "${AppApiLinks.serviceKeywords.boatName}/$keyword",
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }

  Future<StatusRequest> getServiceTypeKeywords(String keyword) async {
    String accessToken = await getAccessToken();
    final res = await get(
      "${AppApiLinks.serviceKeywords.serviceType}/$keyword",
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(res);
  }
}
