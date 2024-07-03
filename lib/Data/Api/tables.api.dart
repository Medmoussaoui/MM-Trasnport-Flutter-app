import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.api.dart';
import 'package:mmtransport/Data/data.decoder.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Functions/access_token.dart';
import 'package:mmtransport/Functions/handling_api_responce.dart';
import 'package:mmtransport/class/api_connection.dart';

class TablesApi extends GetConnect {
  Future<StatusRequest> getTables({int page = 0}) async {
    String accessToken = await getAccessToken();
    final responce = await get(
      AppApiLinks.tables.getTables,
      headers: {
        "access-token": accessToken,
        "page": "$page",
      },
    );
    final res = handleApiResponce(responce);
    if (res.isSuccess) res.data = CustomDataDecoder.tablesResponceDataDecoder(res.data);
    return res;
  }

  Future<StatusRequest> renameTable(String tableName, int tableId) async {
    String accessToken = await getAccessToken();
    final responce = await put(
      AppApiLinks.tables.renameTable,
      {
        "newName": tableName,
        "tableId": tableId,
      },
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(responce);
  }

  getTablesBySearch(String keyword) async {
    String accessToken = await getAccessToken();
    final res = await get(
      AppApiLinks.tables.getTables,
      headers: {
        "access-token": accessToken,
        "keyword": keyword,
      },
    );
    return handleApiResponce(res);
  }

  /// if create table success will return tableId in Data propertie of
  /// StatusRequest
  ///
  Future<StatusRequest> createNewTable(String tableName) async {
    String accessToken = await getAccessToken();
    final responce = await post(
      AppApiLinks.tables.createTable,
      {"tableName": tableName},
      headers: {"access-token": accessToken},
    );
    final res = handleApiResponce(responce);
    if (res.isSuccess) res.data = TableEntity.fromJson(res.data);
    return res;
  }

  Future<StatusRequest> removeTable(int tableId) async {
    String accessToken = await getAccessToken();
    final responce = await delete(
      "${AppApiLinks.tables.deleteTable}/$tableId",
      headers: {"access-token": accessToken},
    );
    return handleApiResponce(responce);
  }
}
