import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.table.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/dates.dart';

class ShortServiceTable extends StatelessWidget {
  final ServiceEntity service;

  const ShortServiceTable({
    super.key,
    required this.service,
  });

  BorderRadius? _topBorder(int index) {
    if (index == 0) {
      return const BorderRadius.only(topRight: Radius.circular(10));
    }
    if ((index + 1) == AppTableData.tableColumns.length) {
      return const BorderRadius.only(topLeft: Radius.circular(10));
    }
    return null;
  }

  Row _buildColumns() {
    return Row(
      textDirection: TextDirection.rtl,
      children: List.generate(
        AppTableData.tableColumns.length,
        (index) {
          return ShortServiceTableColumn(
            title: AppTableData.tableColumns[index],
            borderRadius: _topBorder(index),
          );
        },
      ),
    );
  }

  Row _buildRows() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        ShortServiceTableRow(
          value: service.boatName!,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
          ),
        ),
        ShortServiceTableRow(value: service.serviceType!),
        ShortServiceTableRow(value: service.price.toString()),
        ShortServiceTableRow(
          value: getDate(service.dateCreate!),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildColumns()),
        Expanded(child: _buildRows()),
      ],
    );
  }
}

class ShortServiceTableColumn extends StatelessWidget {
  final String title;
  final BorderRadius? borderRadius;

  const ShortServiceTableColumn({
    super.key,
    this.borderRadius,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: borderRadius,
          border: Border.all(
            color: AppColors.geyDeep.withOpacity(0.4),
            width: 0.5,
          ),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShortServiceTableRow extends StatelessWidget {
  final String value;
  final BorderRadius? borderRadius;

  const ShortServiceTableRow({
    super.key,
    this.borderRadius,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          border: Border.all(
            color: AppColors.geyDeep.withOpacity(0.4),
            width: 0.5,
          ),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
