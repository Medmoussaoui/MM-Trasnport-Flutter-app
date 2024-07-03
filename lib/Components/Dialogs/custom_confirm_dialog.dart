import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_primary_button.dart';
import 'package:mmtransport/Constant/app.color.dart';

Future<void> customConfirmDialog({
  String? subTitle,
  String? title,
  Function? onCancel,
  Function? onAccept,
  String? cancelTitle,
  String? confirmTitle,
  String? cancelTitleColor,
  Color? confirmTitleColor,
  Color? confirmButtonColor,
  Color? cancelButtonColor,
  IconData? icon,
  Color? color,
  bool barrierDismissible = true,
}) async {
  cancelTitle = cancelTitle ?? "Cancel";
  confirmTitle = confirmTitle ?? "Accept";
  subTitle = subTitle ?? "subTitlesubTitlesubTitlesubTitle";
  title = title ?? "title";
  icon = icon ?? Icons.add;
  color = color ?? AppColors.primaryColor;
  Color lightColor = color.withOpacity(0.2);

  await Get.dialog(
    barrierDismissible: barrierDismissible,
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Material(
            child: Container(
              color: Colors.white,
              height: Get.height * 0.4,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: (Get.height * 0.4) * 0.30,
                    padding: const EdgeInsets.all(25),
                    width: double.infinity,
                    color: lightColor,
                    child: FittedBox(
                      child: Icon(icon, color: color),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomLargeTitle(
                            color: Colors.black87,
                            title: title,
                            size: 18,
                          ),
                          const SizedBox(height: 7.0),
                          Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black.withOpacity(0.7),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Get.height * 0.1,
                    color: AppColors.gey.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomPrimaryButton(
                            elevation: 1,
                            borderRadius: 7.0,
                            buttonText: cancelTitle,
                            textColor: AppColors.geyDeep,
                            bottomPadding: 0,
                            topPadding: 0,
                            color: cancelButtonColor ?? Colors.white,
                            onPressed: () {
                              if (onCancel != null) onCancel();
                              Get.back();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomPrimaryButton(
                            elevation: 1,
                            borderRadius: 7.0,
                            buttonText: confirmTitle,
                            bottomPadding: 0,
                            topPadding: 0,
                            color: confirmButtonColor ?? Colors.red,
                            onPressed: () {
                              if (onAccept != null) onAccept();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
