import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.color.dart';

Future<T?> customShowBottoSheet<T>(Widget widget, {bool isDismissible = true}) async {
  return await Get.bottomSheet(
    WillPopScope(
      child: widget,
      onWillPop: () async {
        return isDismissible;
      },
    ),
    elevation: 0.0,
    isDismissible: isDismissible,
    barrierColor: AppColors.geyDeep.withOpacity(0.3),
  );
}
