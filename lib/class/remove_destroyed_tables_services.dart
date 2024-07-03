import 'package:mmtransport/Functions/to_values.dart';
import 'package:mmtransport/class/database.dart';

class DestroyedTables {
  static Future<String> getTableIds() async {
    final db = await AppDatabase.database;
    final query = await db.rawQuery("SELECT tableId FROM Tables WHERE tableId IS NOT NULL");
    final tableIds = query.map((e) => e["tableId"]).toList();
    return toValues(tableIds);
  }

  static deleteDestroyedServices() async {
    final db = await AppDatabase.database;
    final tabeIds = await getTableIds();
    await db.delete("Services", where: "tableId NOT IN ($tabeIds) AND tableId > 0");
  }
}
