import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';

Future<void> customPrimaryDialog({
  void Function()? onTap,
  String? title,
  String? buttonTitle,
  Color? buttonTitleColor,
  String? subTitle,
  IconData? icon,
  Color? color,
  bool barrierDismissible = true,
}) async {
  title = title ?? "title";
  subTitle = subTitle ?? "sbtitle balalalal";
  buttonTitle = buttonTitle ?? "OK";
  buttonTitleColor = buttonTitleColor ?? AppColors.primaryColor;
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
                    height: (Get.height * 0.4) * 0.35,
                    padding: const EdgeInsets.all(25),
                    width: double.infinity,
                    color: lightColor,
                    child: FittedBox(
                      child: Icon(icon, color: color),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(height: 0.0, thickness: 0.5),
                  ),
                  Expanded(
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        if (onTap != null) onTap();
                      },
                      child: Center(
                        child: CustomLargeTitle(
                          title: buttonTitle,
                          size: 14,
                          color: buttonTitleColor,
                        ),
                      ),
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
