import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_date_picker.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';

class CustomCreateServiceDateForm extends StatefulWidget {
  final ValueNotifier<DateTime> date;
  final void Function(DateTime date) onSave;
  final void Function(DateTime)? onChange;

  const CustomCreateServiceDateForm({
    Key? key,
    required this.onSave,
    required this.onChange,
    required this.date,
  }) : super(key: key);

  @override
  State<CustomCreateServiceDateForm> createState() => _CustomCreateServiceDateFormState();
}

class _CustomCreateServiceDateFormState extends State<CustomCreateServiceDateForm> {
  bool clickEffect = false;

  runClickEffect() async {
    setState(() => clickEffect = true);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => clickEffect = false);
  }

  void showDatePickert() {
    customShowBottoSheet(
      CustomDatePicker(
        date: widget.date.value,
        onSave: widget.onSave,
        onChange: widget.onChange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePickert();
        runClickEffect();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gey),
          borderRadius: BorderRadius.circular(15),
          color: clickEffect ? AppColors.gey : AppColors.gey.withOpacity(0.15),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month_outlined,
              color: AppColors.secondColor,
              size: 23,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: FittedBox(
                  child: ValueListenableBuilder(
                    valueListenable: widget.date,
                    builder: (_, DateTime date, child) {
                      return CustomLargeTitle(
                        title: getDate(widget.date.value.toString()),
                        color: Colors.black54,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
