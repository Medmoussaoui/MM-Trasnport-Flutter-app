import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Components/navigation_bar_item.dart';

class CustomServiceStatus extends StatelessWidget {
  final RxInt groupValue;
  final void Function(int value) onChange;

  const CustomServiceStatus({
    required this.groupValue,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomSelectServiceStatus(
              onChange: onChange,
              groupValue: groupValue,
            ),
          ),
          const SizedBox(width: 25.0),
          const CustomLargeTitle(title: "الحالة", size: 16),
        ],
      ),
    );
  }
}

class CustomSelectServiceStatus extends StatelessWidget {
  final RxInt groupValue;
  final void Function(int value) onChange;

  const CustomSelectServiceStatus({
    required this.groupValue,
    required this.onChange,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          Expanded(
            child: CustomNavigationTapItem(
              selectColor: Colors.white,
              unSelectColor: AppColors.secondColor,
              selectFillColor: AppColors.secondColor,
              groupValue: groupValue.value,
              value: 1,
              title: "مدفوعة",
              onTap: onChange,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CustomNavigationTapItem(
              selectColor: Colors.white,
              unSelectColor: AppColors.secondColor,
              selectFillColor: AppColors.secondColor,
              groupValue: groupValue.value,
              value: 0,
              title: "غير مدفوعة",
              onTap: onChange,
            ),
          ),
        ],
      );
    });
  }
}
