import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Components/navigation_bar_item.dart';

class CustomInvoiceState extends StatelessWidget {
  final RxInt groupValue;
  final void Function(int value) onChange;
  final bool active;

  const CustomInvoiceState({
    required this.groupValue,
    required this.onChange,
    required this.active,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !active,
      child: Opacity(
        opacity: active ? 1.0 : 0.7,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5.0,
                spreadRadius: 2.5,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: CustomSelectInvoiceState(
                  onChange: onChange,
                  groupValue: groupValue,
                ),
              ),
              const SizedBox(width: 25.0),
              const CustomLargeTitle(title: "حالة الفاتورة", size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSelectInvoiceState extends StatelessWidget {
  final RxInt groupValue;
  final void Function(int value) onChange;

  const CustomSelectInvoiceState({
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
