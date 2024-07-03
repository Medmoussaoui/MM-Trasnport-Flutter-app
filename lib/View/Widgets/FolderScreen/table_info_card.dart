import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/Functions/dates.dart';

class TableCardInfo extends StatelessWidget {
  final TableEntity table;
  final int value;
  final int groupValue;
  final Function(int value) onTap;

  const TableCardInfo({
    super.key,
    required this.table,
    required this.value,
    required this.onTap,
    required this.groupValue,
  });

  bool _isSelected() {
    return value == groupValue;
  }

  BoxShadow _shadow(bool isSelect) {
    if (isSelect) {
      return BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        blurRadius: 5,
        spreadRadius: 1.5,
      );
    }
    return BoxShadow(color: Colors.grey.withOpacity(0));
  }

  String shortStringBaots() {
    String boats = table.boats!;
    if (boats.length <= 15) return "...$boats";
    boats = table.boats!.substring(0, 15);
    return "...$boats";
  }

  String lastEdit() {
    if (table.lastEdit == null) return "none";
    return getDateAndTime(table.lastEdit!);
  }

  @override
  Widget build(BuildContext context) {
    bool isSelect = _isSelected();
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        width: double.infinity,
        height: Get.height * 0.15,
        decoration: BoxDecoration(
          color: isSelect ? Colors.white : Colors.white24,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColors.gey, width: 0.5),
          boxShadow: [_shadow(isSelect)],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTableIcon(),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTableInfoName(tableName: table.tableName!),
                          TableCardBoats(boats: shortStringBaots()),
                          TableCardLastEdit(date: lastEdit()),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Radio(
                      activeColor: AppColors.secondColor,
                      value: value,
                      groupValue: groupValue,
                      onChanged: (v) {},
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomTableIcon extends StatelessWidget {
  const CustomTableIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(10),
          ),
        ),
        child: const FittedBox(
          child: Icon(
            Icons.table_chart_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class TableCardBoats extends StatelessWidget {
  final String boats;

  const TableCardBoats({
    required this.boats,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        const Icon(
          Icons.directions_boat_rounded,
          size: 16,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            "القوارب",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.secondColor,
            ),
          ),
        ),
        Text(
          boats,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class TableCardLastEdit extends StatelessWidget {
  final String date;

  const TableCardLastEdit({
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        const Icon(
          Icons.history_rounded,
          color: AppColors.secondColor,
          size: 16,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0),
          child: Text(
            "اخر تعديل",
            style: TextStyle(
              fontSize: 11,
              color: AppColors.geyDeep,
            ),
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.geyDeep,
          ),
        ),
      ],
    );
  }
}

class CustomTableInfoName extends StatelessWidget {
  final String tableName;

  const CustomTableInfoName({
    required this.tableName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        tableName,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
