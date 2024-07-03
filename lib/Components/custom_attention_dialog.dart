import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';

customAttentionDialogSheet({
  required String title,
  required String subTitle,
  Icon? icon,
}) {
  icon = icon ?? const Icon(Icons.error_outline_rounded);
  Icon customIcons = Icon(
    icon.icon ?? Icons.error_outline_rounded,
    color: icon.color ?? Colors.orange,
    size: icon.size ?? 34,
  );
  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: customIcons.color!.withOpacity(0.1),
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: customIcons,
          ),
          const SizedBox(height: 30),
          CustomLargeTitle(title: title, size: 16.0),
          const SizedBox(height: 10.0),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.geyDeep,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
