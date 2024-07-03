import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';

class ServiceKeywordsLocal {
  static Future<StatusRequest> getBoatNameKeywords(String keyword) async {
    final db = await AppDatabase.database;
    final keywords = await db.query(
      "Services",
      distinct: true,
      columns: ["boatName"],
      where: "LOWER(boatName) LIKE ? ",
      whereArgs: ["%${keyword.toLowerCase()}%"],
    );
    return StatusRequest(connectionStatus: ConnectionStatus.success, data: keywords);
  }

  static Future<StatusRequest> getServiceTypeKeywords(String keyword) async {
    final db = await AppDatabase.database;
    final keywords = await db.query(
      "Services",
      distinct: true,
      columns: ["serviceType"],
      where: "LOWER(serviceType) LIKE ? ",
      whereArgs: ["%${keyword.toLowerCase()}%"],
    );
    return StatusRequest(connectionStatus: ConnectionStatus.success, data: keywords);
  }
}
