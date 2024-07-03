import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/primary.dart';

Future<void> noInternetDialog({Function? onTap}) async {
  await customPrimaryDialog(
    title: "لا يوجد انترنيت",
    subTitle: "لايوجد اتصال بالانترنيت المرجو المحاولة لاحقا",
    buttonTitle: "حسنا",
    color: Colors.orange,
    icon: Icons.wifi_off,
    onTap: () {
      Get.back();
      if (onTap != null) onTap();
    },
  );
}
