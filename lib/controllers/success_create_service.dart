import 'package:get/get.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';

class SuccessCreateServiceController extends GetxController {
  late ServiceEntity service;
  late void Function() close;

  @override
  void onClose() {
    close();
    super.onClose();
  }

  @override
  void onInit() {
    service = Get.arguments["serviceEntity"];
    close = Get.arguments["onClose"];
    super.onInit();
  }
}
