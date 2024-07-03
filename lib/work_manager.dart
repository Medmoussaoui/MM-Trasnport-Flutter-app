/*
import 'package:mmtransport/class/remove_destroyed_tables_services.dart';
import 'package:mmtransport/syncData/index.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask(
    (taskName, inputData) async {
      if (taskName == "syncData") {
        await excuteSyncDataContainer();
      }
      if (taskName == "deleteDestroyedServices") {
        await DestroyedTables.deleteDestroyedServices();
      }
      return Future.value(true);
    },
  );
}

Future<void> registerPeriodicTasks() async {
  await Workmanager().registerPeriodicTask(
    "sync",
    "syncData",
    constraints: Constraints(networkType: NetworkType.connected),
    frequency: const Duration(minutes: 15),
  );
  await Workmanager().registerPeriodicTask(
    "freshDeskone",
    "deleteDestroyedServices",
    frequency: const Duration(minutes: 20),
  );
}

Future<void> initialWorkManager() async {
  await Workmanager().initialize(callbackDispatcher);
  await registerPeriodicTasks();
}

*/