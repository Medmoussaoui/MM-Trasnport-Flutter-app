import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Dialogs/primary.dart';

customInternalServerProblemDialog() {
  customPrimaryDialog(
    icon: Icons.error_outline_rounded,
    color: Colors.orange,
    buttonTitle: "حسنا",
    onTap: () {
      Get.back();
    },
    title: "اوووبس",
    subTitle: "حدثت مشكلة اثناء معالجة الطلب المرجو اعادة المحاولة",
  );
}
