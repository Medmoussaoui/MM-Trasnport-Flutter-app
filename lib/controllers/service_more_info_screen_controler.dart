import 'package:get/get.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';

class ServiceModeInfoScreenController extends GetxController {
  late ServiceEntity serviceEntity;

  void initialArgements() {
    serviceEntity = Get.arguments['service'];
  }

  @override
  void onInit() {
    initialArgements();
    super.onInit();
  }
}
