import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static Future<Database> get database async {
    if (_db == null) await AppDatabase().initial();
    return _db!;
  }

  static Database? _db;

  Future<String> _path() async {
    String dbPath = await getDatabasesPath();
    return join(dbPath, 'mm-transport.db');
  }

  Future<void> initial() async {
    final path = await _path();
    _db = await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  _onCreate(Database db, int version) async {
    final services = _createServiceTable(db);
    final trucks = _createTrucksTable(db);
    final tables = _createTablesTable(db);
    await services;
    await trucks;
    await tables;
  }

  Future<void> _createServiceTable(Database db) async {
    await db.execute("""CREATE TABLE Services (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      serviceId INTEGER,
      tableId INTEGER,
      truckId INTEGER,
      driverId INTEGER,
      boatName TEXT,
      serviceType TEXT,
      price FLOAT,
      note TEXT,
      pay_from INTEGER,
      driverName TEXT,
      truckNumber TEXT,
      truckOwner TEXT,
      dateCreate DATETIME
    );""");
  }

  Future<void> _createTrucksTable(Database db) async {
    await db.execute("""CREATE TABLE Trucks (
      id INTEGER,
      truckNumber TEXT,
      truckName TEXT,
      truckOwner TEXT
    );""");
  }

  Future<void> _createTablesTable(Database db) async {
    await db.execute("""CREATE TABLE Tables (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      tableId INTEGER,
      tableName TEXT,
      boats TEXT,
      dateCreate TEXT,
      lastEdit TEXT
    );""");
  }
}
