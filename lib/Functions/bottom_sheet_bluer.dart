import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';
import '../Constant/app.color.dart';

Future<T?> customBluerShowBottoSheet<T>(
  Widget widget, {
  bool isDismissible = true,
  bool expand = true,
  bool showSlider = true,
  double blurSigmaX = 5.0,
  double blurSigmaY = 5.0,
  double topMarginFraction = 0.15,
  Color? backgroundColor,
}) async {
  return await Get.bottomSheet(
    GestureDetector(
      onTap: () {
        if (isDismissible) {
          Get.back();
        }
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigmaX, sigmaY: blurSigmaY),
        child: Container(
          margin: EdgeInsets.only(top: Get.height * topMarginFraction),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showSlider) const CustomBottomSheetSlider(),
              Flexible(child: widget),
            ],
          ),
        ),
      ),
    ),
    isScrollControlled: expand,
    elevation: 0.0,
    isDismissible: isDismissible,
    barrierColor: AppColors.black.withOpacity(0.5),
  );
}
