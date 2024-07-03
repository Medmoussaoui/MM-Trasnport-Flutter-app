import 'package:mmtransport/Data/data.decoder.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Operations/get_tables.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';

class GetTransferTablesController extends GetTablesController {
  final TableEntity? from;

  GetTransferTablesController(this.from);

  @override
  Future<StatusRequest> getTablesLocally() async {
    if (from == null) return await GetTablesController().getTables();
    List query = [];
    if (from!.tableId == null) query = await getTablesById();
    if (from!.tableId != null) query = await getTablesByTableId();
    final res = StatusRequest().success();
    res.data = CustomDataDecoder.tablesResponceDataDecoder(query);
    return res;
  }

  Future<List<Map<String, Object?>>> getTablesById() async {
    final db = await AppDatabase.database;
    return await db.query("Tables", where: "id != ?", whereArgs: [from!.id]);
  }

  Future<List<Map<String, Object?>>> getTablesByTableId() async {
    final db = await AppDatabase.database;
    return await db.query("Tables", where: "tableId != ?", whereArgs: [from!.tableId]);
  }
}
