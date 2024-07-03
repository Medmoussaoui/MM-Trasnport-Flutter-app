import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';
import 'package:mmtransport/class/developer.dart';

enum SyncDataStatus { non, syncing, done, syncProblem }

enum TableColumnDataType { text, integer, float }

class SyncTableScheama {
  final String tableName;
  final List<SyncTableColumn> columns;

  SyncTableScheama({
    required this.tableName,
    required this.columns,
  }) {
    _setReferenceColumn();
  }

  Future<List<Map<String, dynamic>>> query() async {
    final db = await AppDatabase.database;
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> queryWhere(
    String? where,
    List<Object?>? whereArgs,
  ) async {
    final db = await AppDatabase.database;
    return await db.query(tableName, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(int ref) async {
    final db = await AppDatabase.database;
    return await db.delete(tableName, where: "ref = ?", whereArgs: [ref]);
  }

  Future<int> deleteWhere(
    String? where,
    List<Object?>? whereArgs,
  ) async {
    final db = await AppDatabase.database;
    return await db.delete(tableName, where: where, whereArgs: whereArgs);
  }

  Future<int> clear() async {
    final db = await AppDatabase.database;
    return await db.delete(tableName);
  }

  Future<int> insert(Map<String, Object?> values) async {
    final db = await AppDatabase.database;
    return db.insert(tableName, values);
  }

  Future<int> update(Map<String, Object?> values, String? where, List? whereArgs) async {
    final db = await AppDatabase.database;
    return db.update(tableName, values);
  }

  void _setReferenceColumn() {
    columns.add(SyncTableColumn(
      columnName: "requestId",
      dataType: TableColumnDataType.text,
    ));
    columns.insert(
      0,
      SyncTableColumn(
        columnName: "ref",
        dataType: TableColumnDataType.integer,
        autoIncrement: true,
      ),
    );
  }

  @override
  String toString() {
    String columnToString = "";
    for (int index = 0; index < columns.length; index++) {
      columnToString += columns[index].toString();
      if ((index + 1) != columns.length) columnToString += ",";
    }
    return """CREATE TABLE IF NOT EXISTS $tableName ($columnToString);""";
  }

  Future<SyncTableScheama> initial() async {
    String sql = toString();
    final db = await AppDatabase.database;
    await db.execute(sql);
    return this;
  }
}

class SyncTableColumn {
  final String columnName;
  final TableColumnDataType dataType;
  final bool autoIncrement;

  SyncTableColumn({
    required this.columnName,
    required this.dataType,
    this.autoIncrement = false,
  });

  @override
  String toString() {
    String column = " $columnName ${dataType.name} ";
    if (autoIncrement) column += "PRIMARY KEY AUTOINCREMENT NOT NULL ";
    return column;
  }
}

abstract class SyncContainer {
  final SyncTableScheama store;

  List<dynamic> storeData = [];

  SyncContainer(this.store);

  bool get needSync => totalOperations > 0;

  int get totalOperations => storeData.length;

  int totalSuccessOperation = 0;

  int totalFaildOperation = 0;

  Future<StatusRequest> request(dynamic item);

  Future<void> forse(dynamic item);

  Future<void> onStart() async {}

  Future<void> onEnd() async {}

  Future<void> initialStore() async {
    await store.initial();
    storeData = await store.query();
  }

  Future<void> onDrop(dynamic item) async {}

  Future<void> dropItem(dynamic item) async {
    await store.delete(item["ref"]);
    storeData.remove(item);
    await onDrop(item);
  }

  int operationDone() {
    totalSuccessOperation++;
    return totalSuccessOperation;
  }

  int operationFaild() {
    totalFaildOperation++;
    return totalFaildOperation;
  }

  Future<void> forseSync(StatusRequest res, dynamic item) async {
    if (!res.isConnectionError) {
      operationDone();
      await Future.wait([forse(item), dropItem(item)]);
      return;
    }
    operationFaild();
  }

  Future<void> sync({bool forse = false}) async {
    await onStart();
    for (final item in storeData) {
      StatusRequest responce = await request(item);
      if (responce.isSuccess) {
        operationDone();
        await dropItem(item);
        continue;
      }
      if (forse) {
        await forseSync(responce, item);
        continue;
      }
      operationFaild();
    }
    await onEnd();
  }
}

class SyncDataContainer {
  final List<SyncContainer> containers;

  static bool forse = false;

  int totalOperations = 0;

  int totalSuccessOperations = 0;

  int totalFaildOperations = 0;

  SyncDataContainer(this.containers);

  bool get needSync => totalOperations > 0;

  Future<SyncDataContainer> initial() async {
    totalFaildOperations = 0;
    totalSuccessOperations = 0;
    totalOperations = 0;
    forse = false;
    for (SyncContainer container in containers) {
      await container.initialStore();
      totalOperations += container.totalOperations;
    }
    return this;
  }

  Future<void> onStart() async {
    CustomPrint.printYellowText("[note] Start sync Process");
    showSyncProgressBarNotification();
  }

  Future<void> onEnd() async {
    forse = false;
    closeSyncProgressBarNotification();
  }

  void endSyncContainer(SyncContainer container) {
    totalFaildOperations += container.totalFaildOperation;
    totalSuccessOperations += container.totalSuccessOperation;
  }

  Future<bool> syncWithForse() async {
    forse = true;
    return await sync();
  }

  Future<bool> sync() async {
    if (!needSync) {
      onEnd();
      return true;
    }
    await onStart();
    // await Future.delayed(const Duration(seconds: 5));
    for (SyncContainer container in containers) {
      await container.sync(forse: forse);
      endSyncContainer(container);
    }
    await onEnd();
    return totalSuccessOperations == totalOperations;
  }

  void showSyncProgressBarNotification() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "syncData",
        title: "sync Data to service",
        notificationLayout: NotificationLayout.ProgressBar,
        autoDismissible: false,
      ),
    );
  }

  void closeSyncProgressBarNotification() async {
    AwesomeNotifications().cancel(1);
  }
}
