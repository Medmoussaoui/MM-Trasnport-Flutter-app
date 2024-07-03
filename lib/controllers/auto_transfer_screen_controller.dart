import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/custom_confirm_dialog.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/Api/services.api.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Data/entitys/transfer.entity.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/class/database.dart';

class AutoTransferDataScreenController extends GetxController {
  late ValueNotifier<StatusRequest> transferRequest;

  late TransferResult transferResult;

  late Function(StatusRequest req) onOut;

  static Future<List<ServiceEntity>> getTransferData() async {
    final db = await AppDatabase.database;
    final query = await db.query("Services", where: "tableId IS NULL");
    if (query.isEmpty) return [];
    List<ServiceEntity> services = query.map<ServiceEntity>((item) => ServiceEntity.fromJson(item)).toList();
    return services;
  }

  startTransfer() async {
    transferRequest.value = transferRequest.value.loading();
    final res = await ServicesApi().autoTransfer();
    if (res.isSuccess) transferResult = res.data;
    transferRequest.value = res;
  }

  onBack() {
    if (transferRequest.value.isSuccess) {}
  }

  initArgs() {
    onOut = Get.arguments["onOut"];
  }

  confirmOutOnTransferRun() async {
    if (!transferRequest.value.isLoading) return true;
    bool out = false;
    await customConfirmDialog(
      color: AppColors.primaryColor,
      icon: Icons.logout_rounded,
      title: "الخروج",
      subTitle: "هل تريد الخروج من هذه الصفحة",
      cancelTitle: "لا",
      confirmTitle: "نعم",
      onAccept: () {
        out = true;
        Get.back();
      },
      onCancel: () {},
    );
    return out;
  }

  @override
  void onClose() {
    onOut(transferRequest.value);
    super.onClose();
  }

  @override
  void onInit() {
    initArgs();
    transferRequest = ValueNotifier(StatusRequest(connectionStatus: ConnectionStatus.success));
    super.onInit();
  }
}
