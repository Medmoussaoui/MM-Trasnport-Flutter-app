import 'package:flutter/material.dart';
import 'package:mmtransport/Components/Table/Controller/filter_rows.dart';
import 'package:mmtransport/Constant/app.color.dart';

class FilterItemValue extends StatefulWidget {
  final TableFilterController controller;
  final String value;
  const FilterItemValue({Key? key, required this.value, required this.controller}) : super(key: key);

  @override
  State<FilterItemValue> createState() => _FilterItemValueState();
}

class _FilterItemValueState extends State<FilterItemValue> {
  bool isSelect = false;
  bool effect = false;

  bool _isSelect() {
    return widget.controller.currentColumn.isValueSelected(widget.value);
  }

  Icon _checkIcon() {
    Color color = isSelect ? AppColors.secondColor : AppColors.gey;
    return Icon(Icons.done, size: 23, color: color);
  }

  @override
  Widget build(BuildContext context) {
    isSelect = _isSelect();
    return GestureDetector(
      onTap: () async {
        widget.controller.selectValue(widget.value);
        setState(() => effect = true);
        await Future.delayed(const Duration(milliseconds: 100));
        setState(() => effect = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        color: effect ? AppColors.gey.withOpacity(0.3) : Colors.white,
        child: Row(
          children: [
            Text(
              widget.value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            _checkIcon(),
          ],
        ),
      ),
    );
  }
}
