import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomSyncDialogButtonAction extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  final Color color;
  final Color? textColor;

  const CustomSyncDialogButtonAction({
    super.key,
    required this.onPressed,
    required this.title,
    required this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 0.0,
      height: 40,
      onPressed: onPressed,
      color: color,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}

syncStateDialog({required Function sync, required Function forseSync}) {
  Get.bottomSheet(
    Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.cloud_sync_outlined,
                  size: 30,
                  color: AppColors.secondColor,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                CustomLargeTitle(title: "مزامنة البيانات", size: 18.0),
                SizedBox(height: 5.0),
                Text(
                  "لديك بيانات تحتاج إلى المزامنة ملاحظة قد يتم فقد بعض البيانات عند تشغيل وضع الإجبار",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 15.0, color: AppColors.geyDeep),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Divider(thickness: 0.5, height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: CustomSyncDialogButtonAction(
                    color: Colors.red[50]!,
                    onPressed: () => forseSync(),
                    title: "مزامنة باجبار",
                    textColor: Colors.red[600],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomSyncDialogButtonAction(
                    color: AppColors.secondColor,
                    onPressed: () => sync(),
                    title: "مزامنة",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
