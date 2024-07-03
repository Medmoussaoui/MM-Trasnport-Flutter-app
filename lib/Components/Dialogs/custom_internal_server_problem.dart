import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/primary.dart';

Future<void> customInternalServerErrorDialog({Function()? ontap}) async {
  await customPrimaryDialog(
    barrierDismissible: true,
    icon: Icons.sync_problem,
    color: Colors.orange,
    title: "حدثة مشكلة",
    subTitle: "حدثت مشكلة في الاتصال بالخادم قم بالمحاولة من جديد",
    buttonTitle: "حاول مرة اخرى",
    onTap: ontap ?? () => Get.back(),
  );
}
