import 'package:mmtransport/class/database.dart';
import 'package:sqflite/sqflite.dart';

abstract class RefrecherData<T> {
  late Database db;

  /// Implement the concept of insert single new item in locale storge
  /// to excute this methode in [_insertAll] methode to insert all
  /// new items immediately
  ///
  ///
  Future<dynamic> insert(T item);

  /// Implement clear locale data concept from locale storage
  ///
  ///
  Future<void> clearLocale();

  /// Implemnt the return data items from locale storage concept
  /// after refrech methode done
  ///
  ///
  Future<List<T>> getItems();

  /// Important Items are the items that we can remove them from
  /// locale storage
  ///
  ///
  Future<List<T>> getImportantItems();

  /// insert all new items comes from remote server
  ///
  ///
  _insertAll(List<T> newItems) async {
    List<Future<dynamic>> futures = [];
    for (final item in newItems) {
      futures.add(insert(item));
    }
    await Future.wait(futures);
  }

  /// main methode to excute the refrech concept
  ///
  ///
  Future<List<T>> refrech(List<T> remoteData) async {
    db = await AppDatabase.database;
    List<T> newItems = await getImportantItems();
    newItems.addAll(remoteData);
    await clearLocale();
    await _insertAll(newItems);
    return await getItems();
  }
}
