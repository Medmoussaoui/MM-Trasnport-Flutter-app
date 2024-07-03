import 'package:mmtransport/Data/entitys/truck_entity.dart';
import 'package:mmtransport/class/database.dart';

class TruckLocal {
  static Future<List<TruckEntity>> getTrucks() async {
    final database = await AppDatabase.database;
    var query = await database.query("Trucks");
    List<TruckEntity> trucks = [];
    if (query.isNotEmpty) {
      trucks = query.map((truck) => TruckEntity.fromJson(truck)).toList();
    }
    return trucks;
  }

  static Future<TruckEntity?> getTruckByNumber(String truckNumber) async {
    final database = await AppDatabase.database;
    final truck = await database.query(
      "Trucks",
      where: "truckNumber = ?",
      whereArgs: [truckNumber],
    );

    return truck.isNotEmpty ? TruckEntity.fromJson(truck[0]) : null;
  }

  static Future<void> addTrucks(List<TruckEntity> trucks) async {
    final database = await AppDatabase.database;
    for (TruckEntity truck in trucks) {
      await database.insert("Trucks", truck.toMap());
    }
  }

  static Future<void> clearTrucks() async {
    final database = await AppDatabase.database;
    await database.delete("Trucks");
  }
}
