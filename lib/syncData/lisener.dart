import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Constant/app.routes.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/Functions/check_internet_access.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/syncData/index.dart';
import 'package:mmtransport/syncData/syn_state_dilaog.dart';

enum DeviceConnectionState {
  non,
  syncing,
  syncProblem,
  online,
  offline,
  noInternetAccess,
}

class SyncDataContainerLisener extends GetxController {
  ValueNotifier<DeviceConnectionState> deviceState = ValueNotifier(DeviceConnectionState.non);
  showSyncStateDialog() {
    if (deviceState.value != DeviceConnectionState.syncProblem) return;
    syncStateDialog(
      sync: () {
        Get.back();
        startSync();
      },
      forseSync: () {
        Get.back();
        startSyncWithForce();
      },
    );
  }

  /// if equal true that means the sync loading dialog is open
  /// if equal false it means the loading dialog is not open or closed
  bool syncLoadingDialog = false;

  void lisener() async {
    await Future.delayed(const Duration(seconds: 3));
    await excute();
    lisener();
  }

  offline() => deviceState.value = DeviceConnectionState.offline;

  online() => deviceState.value = DeviceConnectionState.online;

  syncing() => deviceState.value = DeviceConnectionState.syncing;

  syncProblem() => deviceState.value = DeviceConnectionState.syncProblem;

  noInternetAccess() => deviceState.value = DeviceConnectionState.noInternetAccess;

  excute() async {
    await Future.delayed(const Duration(seconds: 2));

    bool hasConnection = await hasInternet();
    if (!hasConnection) return offline();

    if (deviceState.value == DeviceConnectionState.syncProblem) return syncProblem();

    online();

    final syncDataContainer = await initialSyncDataContainer();
    if (!syncDataContainer.needSync) return;

    bool hasAccess = await checkInternetAccess();
    if (!hasAccess) {
      noInternetAccess();
      return await trySyncDataWithNoInternetAccess();
    }

    await startSync();
  }

  void endSyncWithProblem() {
    deviceState.value = DeviceConnectionState.syncProblem;
  }

  Future<void> startSync() async {
    if (deviceState.value == DeviceConnectionState.syncing) return;
    bool hasConnection = await hasInternet();
    if (!hasConnection) return AppSnackBars.noInternetAccess();
    if (!syncLoadingDialog) openSyncDialog();
    syncing();
    final syncData = await initialSyncDataContainer();
    bool result = await syncData.sync();
    if (result == false) endSyncWithProblem();
    closeSyncDialog();
  }

  Future<void> startSyncWithForce() async {
    if (deviceState.value == DeviceConnectionState.syncing) return;
    bool hasConnection = await hasInternet();
    if (!hasConnection) return AppSnackBars.noInternetAccess();
    if (!syncLoadingDialog) openSyncDialog();
    syncing();
    final syncData = await initialSyncDataContainer();
    bool result = await syncData.syncWithForse();
    if (result == false) endSyncWithProblem();
    closeSyncDialog();
  }

  Future trySyncDataWithNoInternetAccess() async {
    await Future.delayed(const Duration(seconds: 3));
    bool hasConnection = await hasInternet();
    if (!hasConnection) return offline();
    bool hasAccess = await checkInternetAccess();
    if (hasAccess) return;
    await trySyncDataWithNoInternetAccess();
  }

  void openSyncDialog() {
    if (syncLoadingDialog) return;
    syncLoadingDialog = true;
    customLoadingDailog(
      text: "المرجو الانتضار",
      onWillPop: () async {
        return false;
      },
    );
  }

  void closeSyncDialog() {
    if (!syncLoadingDialog) return;
    syncLoadingDialog = false;
    Get.back();
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onInit() {
    lisener();
    super.onInit();
  }
}
