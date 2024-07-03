import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/Functions/is_paying_off.dart';

class InvoiceCardTableRow extends StatelessWidget {
  final double heigth;
  final EdgeInsetsGeometry? padding;
  final ServiceEntity service;

  const InvoiceCardTableRow({
    super.key,
    required this.service,
    this.heigth = 20,
    this.padding,
  });

  _value(int index) {
    if (index == 0) return service.boatName;
    if (index == 1) return service.serviceType;
    if (index == 2) return "   ${service.price!.toInt()}   ";
    if (index == 3) return getDate(service.dateCreate!);
  }

  @override
  Widget build(BuildContext context) {
    bool isPayingOff = isPayingOffServiceType(_value(1));
    return Row(
      textDirection: TextDirection.rtl,
      children: List.generate(
        4,
        (index) {
          return Expanded(
            child: InvoiceCardRowItem(
              index: index,
              padding: index == 3 ? const EdgeInsets.symmetric(horizontal: 8.0) : padding,
              height: heigth,
              value: _value(index),
              isInactive: service.isInactive == true,
              isPayingOff: isPayingOff,
            ),
          );
        },
      ),
    );
  }
}

class InvoiceCardRowItem extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String value;
  final int index;
  final double height;
  final BorderRadius? borderRadius;
  final bool isInactive;
  final bool isPayingOff;

  const InvoiceCardRowItem({
    super.key,
    this.padding,
    this.height = 20,
    this.borderRadius,
    required this.index,
    required this.value,
    required this.isInactive,
    required this.isPayingOff,
  });

  Border? _border() {
    if (index == 0) return null;
    return const Border(
      right: BorderSide(width: 0.5, color: Colors.black),
    );
  }

  Color _color() {
    if (isInactive) return AppColors.geyDeep;
    if (isPayingOff) return Colors.red;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
        // color: AppColors.gey.withOpacity(0.2),
        border: _border(),
        borderRadius: borderRadius,
      ),
      child: FittedBox(
        child: Text(
          value,
          style: TextStyle(
            color: _color(),
            fontWeight: FontWeight.w500,
            decoration: isInactive ? TextDecoration.lineThrough : null,
          ),
        ),
      ),
    );
  }
}
