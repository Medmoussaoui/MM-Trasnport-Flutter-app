import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomServiceMoreInfoNote extends StatelessWidget {
  final String? note;

  const CustomServiceMoreInfoNote({
    super.key,
    required this.note,
  });

  String _note() {
    if (note == "") return "...";
    return note ?? "...";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Get.height * 0.11,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: FittedBox(
          child: CustomLargeTitle(
            size: 17.0,
            title: _note(),
            color: AppColors.geyDeep,
          ),
        ),
      ),
    );
  }
}
