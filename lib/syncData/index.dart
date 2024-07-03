import 'package:mmtransport/syncData/Containers/sync_add_new_services.dart';
import 'package:mmtransport/syncData/Containers/sync_create_tables.dart';
import 'package:mmtransport/syncData/Containers/sync_delete_services.dart';
import 'package:mmtransport/syncData/Containers/sync_edit_services.dart';
import 'package:mmtransport/syncData/Containers/sync_new_table_services.dart';
import 'package:mmtransport/syncData/Containers/sync_remove_tables.dart';
import 'package:mmtransport/syncData/Containers/sync_save_invoices.dart';
import 'package:mmtransport/syncData/model.dart';

import 'Containers/sync_rename_tables.dart';
import 'Containers/sync_transfer_services.dart';

Future<SyncDataContainer> initialSyncDataContainer() async {
  return SyncDataContainer([
    SyncCreateTables(),
    SyncAddNewService(),
    SyncAddNewTableServices(),
    SyncEditServices(),
    SyncDeleteServices(),
    SyncRenameTables(),
    SyncTransferServices(),
    SyncRemoveTables(),
    SyncSaveInvoices(),
  ]).initial();
}
