import 'package:flutter/material.dart';
import 'package:mmtransport/Components/navigation_bar_item.dart';

import '../../../Constant/app.color.dart';

class InvoiceStoreCustomNavigationBar extends StatefulWidget {
  final void Function(int value) onNavigate;
  final List<String> items;
  final int groupValue;

  const InvoiceStoreCustomNavigationBar({
    super.key,
    required this.onNavigate,
    required this.items,
    required this.groupValue,
  });

  @override
  State<InvoiceStoreCustomNavigationBar> createState() => _InvoiceStoreCustomNavigationBarState();
}

class _InvoiceStoreCustomNavigationBarState extends State<InvoiceStoreCustomNavigationBar> {
  late int groupValue = widget.groupValue;

  @override
  void initState() {
    groupValue = widget.groupValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      scrollDirection: Axis.horizontal,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(left: 10),
          child: CustomNavigationTapItem(
            radius: 10,
            selectColor: Colors.white,
            selectFillColor: AppColors.secondColor,
            unSelectColor: AppColors.secondColor,
            groupValue: groupValue,
            value: index,
            title: widget.items[index],
            onTap: (i) {
              widget.onNavigate(i);
              setState(() {
                groupValue = i;
              });
            },
          ),
        );
      },
    );
  }
}
