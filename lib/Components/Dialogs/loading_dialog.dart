import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';

Future<void> customLoadingDailog({
  required String text,
  Future<bool> Function()? onWillPop,
}) async {
  await Get.dialog(
    WillPopScope(
      onWillPop: onWillPop,
      child: Container(
        width: double.infinity,
        color: Colors.black.withOpacity(0.1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CustomProgressIndicator(
                        size: 40,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 8.0),
                      Text(text),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
