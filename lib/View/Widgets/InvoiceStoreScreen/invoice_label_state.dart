import 'package:flutter/material.dart';

class InvoiceCardCustomLabelState extends StatelessWidget {
  final Color fillColor;
  final Color textColor;
  final String value;

  const InvoiceCardCustomLabelState({
    super.key,
    required this.fillColor,
    this.textColor = Colors.white,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: (Get.width * 0.5) * 0.3,
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: fillColor,
      ),
      child: FittedBox(
        child: Text(
          value,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
