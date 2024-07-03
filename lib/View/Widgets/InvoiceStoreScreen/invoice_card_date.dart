import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Functions/dates.dart';

class InvocieCardDate extends StatelessWidget {
  final String date;

  const InvocieCardDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
      color: AppColors.geyDeep,
      fontSize: 9,
      fontWeight: FontWeight.w500,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: Text(getDateAndTime(date), style: style),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: FittedBox(
                child: Text(
                  "بتاريخ",
                  style: style.copyWith(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
