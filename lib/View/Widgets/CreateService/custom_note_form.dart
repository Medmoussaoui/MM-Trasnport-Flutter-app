import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomCreateServiceNoteForm extends StatelessWidget {
  final TextEditingController noteFormController;

  const CustomCreateServiceNoteForm({
    Key? key,
    required this.noteFormController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.15,
      width: double.infinity,
      child: TextFormField(
        textDirection: TextDirection.rtl,
        controller: noteFormController,
        textInputAction: TextInputAction.go,
        textAlign: TextAlign.center,
        expands: true,
        maxLines: null,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 0.5,
              color: AppColors.geyDeep,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.primaryColor.withOpacity(0.9),
            ),
          ),
          filled: true,
          fillColor: AppColors.gey.withOpacity(0.15),
          hintText: "ملاحضة",
        ),
      ),
    );
  }
}
