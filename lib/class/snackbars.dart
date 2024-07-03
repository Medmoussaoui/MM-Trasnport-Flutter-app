import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Functions/show_custom_snackbar.dart';

class AppSnackBars {
  static successDeleteServices() {
    showCustomSnackBar(
      text: "تم حذف العناصر بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.delete_rounded,
    );
  }

  static emptyTable() {
    showCustomSnackBar(
      text: "الجدول لايحتوي على بيانات",
      backGroundColor: AppColors.black,
      contentColor: Colors.orange,
      iconData: Icons.exposure_zero_rounded,
    );
  }

  static successCreateTable() {
    showCustomSnackBar(
      text: "تم انشاء الجدول بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static successRenameTable() {
    showCustomSnackBar(
      text: "تم تغير اسم الجدول بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static successDeleteTable() {
    showCustomSnackBar(
      text: "تم حذف الجدول بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static successTransferServices() {
    showCustomSnackBar(
      text: "تم نقل العناصر بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static successPayInvoice() {
    showCustomSnackBar(
      text: "تم دفع الفاتورة بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static successUnPayInvoice() {
    showCustomSnackBar(
      text: "تم الغاء دفع الفاتورة بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static noInternetAccess() {
    showCustomSnackBar(
      text: "لايوجد اتصال بالانترنيت",
      backGroundColor: Colors.red[100]!,
      contentColor: Colors.red,
      iconData: Icons.wifi_off_rounded,
    );
  }

  static successSaveInvoice() {
    showCustomSnackBar(
      text: "تم حفض الفاتورة بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static successChangeInvoiceName() {
    showCustomSnackBar(
      text: "تم تغير اسم الفاتورة بنجاح",
      backGroundColor: AppColors.black,
      contentColor: AppColors.secondColor,
      iconData: Icons.done_rounded,
    );
  }

  static problemHappen() {
    showCustomSnackBar(
      text: "حدثت مشكلة",
      backGroundColor: AppColors.black,
      contentColor: Colors.red,
      iconData: Icons.report_problem_rounded,
    );
  }

  static tableNeedSync() {
    showCustomSnackBar(
      text: "الجدول يحتاج الى مزامنة",
      backGroundColor: AppColors.black,
      contentColor: Colors.orange,
      iconData: Icons.cloud_off,
    );
  }

  static serviceNeedSync() {
    showCustomSnackBar(
      text: "بيانات تحتاج الى مزامنة",
      backGroundColor: AppColors.black,
      contentColor: Colors.orange,
      iconData: Icons.cloud_off,
    );
  }
}
