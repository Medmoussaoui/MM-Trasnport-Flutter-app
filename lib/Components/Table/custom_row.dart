import 'package:flutter/material.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/Table/Controller/select_rows.dart';
import 'package:mmtransport/Components/Table/custom_row_item.dart';
import 'package:mmtransport/Data/entitys/service_entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/Functions/is_paying_off.dart';

class CustomTableRow extends StatefulWidget {
  final int index;
  final TableDataController controller;

  const CustomTableRow({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTableRow> createState() => _CustomTableRowState();
}

class _CustomTableRowState extends State<CustomTableRow> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacity;
  late TableSelectRowsController selectRowsController;
  late ServiceEntity service;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    )..addListener(() {
        setState(() {});
      });
    selectRowsController = widget.controller.selectRowsController;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    service = widget.controller.tableRowsData[widget.index];
    final bool isSelected = selectRowsController.isRowSelected(widget.index);
    final bool isPayingOff = isPayingOffServiceType(service.serviceType!);
    final bool isPaid = service.payFrom != null;
    return GestureDetector(
      onLongPress: () {
        selectRowsController.onLongPress(widget.index);
        setState(() {});
      },
      onTap: () {
        selectRowsController.selectRow(widget.index, isSelected);
        setState(() {});
      },
      child: Opacity(
        opacity: _opacity.value,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            CustomRowItem(
              value: service.boatName!,
              isSelected: isSelected,
              index: widget.index,
              ispayingOff: isPayingOff,
              isPaid: isPaid,
              driverId: service.driverId,
            ),
            CustomRowItem(
              value: service.serviceType!,
              isSelected: isSelected,
              index: widget.index,
              ispayingOff: isPayingOff,
              isPaid: isPaid,
              driverId: service.driverId,
            ),
            CustomRowItem(
              value: service.price!.toInt().toString(),
              isSelected: isSelected,
              index: widget.index,
              ispayingOff: isPayingOff,
              isPaid: isPaid,
              driverId: service.driverId,
            ),
            CustomRowItem(
              value: getDate(service.dateCreate!),
              isSelected: isSelected,
              index: widget.index,
              ispayingOff: isPayingOff,
              isPaid: isPaid,
              driverId: service.driverId,
            ),
          ],
        ),
      ),
    );
  }
}
