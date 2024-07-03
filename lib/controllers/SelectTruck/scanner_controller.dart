import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/custom_internal_server_problem.dart';
import 'package:mmtransport/Components/Dialogs/loading_dialog.dart';
import 'package:mmtransport/Components/Dialogs/primary.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/run_barcode_scanner_sound.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:vibration/vibration.dart';

class SelectTruckScannerController {
  final ServiceEntity service;
  final Future<StatusRequest> Function(ServiceEntity service) callBack;
  final Future<void> Function(ServiceEntity service) redirectTo;

  SelectTruckScannerController({
    required this.callBack,
    required this.redirectTo,
    required this.service,
  });

  String code = "";

  Future<void> detect(String detectCode) async {
    if (code.isNotEmpty) return;
    code = detectCode;
    await barcodeScannerSound();
    _loadingDialog();
    await Future.delayed(const Duration(milliseconds: 500));
    excute();
  }

  void reScanCode() => code = "";

  Future<void> excute() async {
    service.truckNumber = code;

    final res = await callBack(service);
    Get.back(); // to close loading dialog

    if (res.isSuccess) return redirectTo(service);

    if (res.isConnectionError) {
      await showNoInternetDialog();
      return reScanCode();
    }

    if (res.isServerFailer) {
      bool fetch = false;
      await customInternalServerErrorDialog(ontap: () {
        Get.back();
        fetch = true;
        // addService();
      });
      if (!fetch) reScanCode();
      return;
    }

    if (res.isRespondError) {
      await invalidDetectedCode();
      return reScanCode();
    }
  }

  Future<void> _loadingDialog() async {
    await customLoadingDailog(
      text: "...جري التحقق",
      onWillPop: () async {
        return false;
      },
    );
  }

  Future<void> showInvalidCodeDialog() async {
    await customPrimaryDialog(
      title: "الرمز غير صحيح",
      subTitle: "فشل التحقق من هذا الرمز يمكنك اعادة مسح الرمز من جديد",
      buttonTitle: "حسنا",
      buttonTitleColor: AppColors.secondColor,
      color: Colors.red,
      icon: Icons.error_outline,
      onTap: () => Get.back(),
    );
  }

  Future<void> showNoInternetDialog() async {
    await customPrimaryDialog(
      title: "لا يوجد انترنيت",
      subTitle: "في هذه الحالة يمكنك تحديد الشاحنة من قائمة الشاحنات الموجدة على الهاتف",
      buttonTitle: "حسنا",
      color: Colors.orange,
      buttonTitleColor: AppColors.secondColor,
      icon: Icons.wifi_off,
      onTap: () => Get.back(),
    );
    reScanCode();
  }

  Future<void> invalidDetectedCode() async {
    Vibration.vibrate(duration: 100);
    await showInvalidCodeDialog();
  }
}
