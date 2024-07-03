import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Data/Api/trucks.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/truck_entity.dart';
import 'package:mmtransport/Data/local/trucks.local.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';

class SelectTruckListController {
  final Future<StatusRequest> Function(ServiceEntity service) callBack;
  final ServiceEntity service;
  final Future<void> Function(ServiceEntity service) redirectTo;

  SelectTruckListController({
    required this.callBack,
    required this.service,
    required this.redirectTo,
  });

  RxBool onContinue = false.obs;
  List<TruckEntity> trucks = [];
  int currentTruck = -1;
  StatusRequest getTrucksRequest = StatusRequest();

  ValueNotifier<bool> stateChange = ValueNotifier(false);

  void onStateChange() {
    stateChange.value = !stateChange.value;
  }

  String getCurrentTruckNumber() => trucks[currentTruck].truckNumber;

  Future<void> loadTrucks() async {
    getTrucksRequest.loading();
    onStateChange();
    bool hasConnection = await hasInternet();
    if (hasConnection) {
      await loadTrucksRemote();
      if (getTrucksRequest.isSuccess) return onStateChange();
    }
    await loadTrucksLocal();
    onStateChange();
  }

  Future<void> loadTrucksRemote() async {
    getTrucksRequest = await TruckApi().getTrucks();
    if (getTrucksRequest.isSuccess) {
      trucks = List.generate(
        getTrucksRequest.data.length,
        (index) => TruckEntity.fromJson(getTrucksRequest.data[index]),
      );
      saveRemoteTrucksLocally(trucks);
    }
  }

  Future<void> saveRemoteTrucksLocally(List<TruckEntity> trucks) async {
    await TruckLocal.clearTrucks();
    await TruckLocal.addTrucks(trucks);
  }

  Future<void> loadTrucksLocal() async {
    trucks = await TruckLocal.getTrucks();
    getTrucksRequest.success();
  }

  void onSelect(int index) {
    currentTruck = index;
  }

  selctAndContinue() async {
    onContinue.value = true;
    service.truckNumber = getCurrentTruckNumber();
    final res = await callBack(service);
    onContinue.value = false;
    if (res.isSuccess) redirectTo(service);
  }
}
