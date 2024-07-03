import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Components/navigation_bar_item.dart';

class CustomSelectTruckNavigationTap extends StatefulWidget {
  final void Function(int value)? onSelect;
  final int groupValue;

  const CustomSelectTruckNavigationTap({
    Key? key,
    this.onSelect,
    this.groupValue = 1,
  }) : super(key: key);

  @override
  State<CustomSelectTruckNavigationTap> createState() => _CustomSelectTruckNavigationTapState();
}

class _CustomSelectTruckNavigationTapState extends State<CustomSelectTruckNavigationTap> {
  late int groupValue;

  void _onTap(int value) {
    setState(() => groupValue = value);
    if (widget.onSelect != null) widget.onSelect!(value);
  }

  @override
  void initState() {
    groupValue = widget.groupValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      color: AppColors.primaryColor,
      child: Row(
        children: [
          Expanded(
            child: CustomNavigationTapItem(
              groupValue: groupValue,
              value: 0,
              title: "اختر من القائمة",
              onTap: _onTap,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: CustomNavigationTapItem(
              groupValue: groupValue,
              value: 1,
              title: "مسح الرمز",
              icon: Icons.qr_code_scanner_rounded,
              onTap: _onTap,
            ),
          ),
        ],
      ),
    );
  }
}
