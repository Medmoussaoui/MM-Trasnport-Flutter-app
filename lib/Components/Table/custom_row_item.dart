import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/class/user.dart';

class CustomRowItem extends StatelessWidget {
  final String value;
  final bool isSelected;
  final int index;
  final bool? ispayingOff;
  final bool isPaid;
  final int? driverId;

  const CustomRowItem({
    Key? key,
    required this.index,
    this.isSelected = false,
    this.ispayingOff,
    this.isPaid = false,
    this.driverId,
    required this.value,
  }) : super(key: key);

  Color _color() {
    if (isSelected) return AppColors.secondColor.withOpacity(0.1);
    return AppColors.backgroundColor;
  }

  Color _textColor() {
    if (isSelected) return AppColors.secondColor;
    if (isPaid) return Colors.black38;
    if (ispayingOff == true) return Colors.red;
    if (driverId == AppUser.user.driverId || driverId == null) {
      return Colors.black;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        height: 40,
        decoration: BoxDecoration(
          color: _color(),
          border: Border.all(
            color: AppColors.geyDeep.withOpacity(0.5),
            width: 0.4,
          ),
        ),
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                decoration: isPaid ? TextDecoration.lineThrough : null,
                color: _textColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
