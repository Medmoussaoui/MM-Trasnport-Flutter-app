import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/controllers/SelectTruck/scanner_controller.dart';
import 'package:mmtransport/controllers/SelectTruck/select_truck_from_list.dart';

class SelectTruckScreenController extends GetxController {
  late PageController pageViewController;
  late SelectTruckScannerController scannerController;
  late SelectTruckListController truckListController;

  /// Need initial from Get.argements
  late final ServiceEntity service;
  late Future<StatusRequest> Function(ServiceEntity serviceEntity) onDetectCallback;
  late Future<void> Function(ServiceEntity service) redirectTo;

  late StatusRequest trucksRequest;
  RxInt curretScreen = 1.obs;

  void initialAgrements() {
    onDetectCallback = Get.arguments["onDelectCallback"];
    service = Get.arguments["serviceEntity"];
    redirectTo = Get.arguments["redirectTo"];
  }

  void navigate(int index) {
    curretScreen.value = index;
    pageViewController.animateToPage(
      curretScreen.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void onInit() {
    initialAgrements();

    scannerController = SelectTruckScannerController(
      callBack: onDetectCallback,
      service: service, // newService here
      redirectTo: redirectTo,
    );

    truckListController = SelectTruckListController(
      service: service, // newService here
      callBack: onDetectCallback,
      redirectTo: redirectTo,
    );

    pageViewController = PageController(initialPage: curretScreen.value);

    super.onInit();
  }

  @override
  void onClose() {
    pageViewController.dispose();
    super.onClose();
  }
}
