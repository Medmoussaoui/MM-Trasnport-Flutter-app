import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar({
  required String text,
  required Color contentColor,
  required Color backGroundColor,
  IconData? iconData,
}) {
  Widget icon = const SizedBox.shrink();
  Widget space = const SizedBox.shrink();

  if (iconData != null) {
    icon = Icon(iconData, color: contentColor);
    space = const SizedBox(width: 10.0);
  }

  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      elevation: 0.0,
      backgroundColor: backGroundColor,
      content: Row(
        textDirection: TextDirection.rtl,
        children: [
          icon,
          space,
          FittedBox(
            child: Text(
              text,
              style: TextStyle(
                color: contentColor,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
