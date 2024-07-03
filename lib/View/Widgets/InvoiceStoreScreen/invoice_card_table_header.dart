import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.table.dart';

class InvoiceCardTableHeader extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? radius;
  const InvoiceCardTableHeader({
    super.key,
    this.padding,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius ?? 8.0),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: List.generate(
          AppTableData.tableColumns.length,
          (index) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FittedBox(
                  child: Text(
                    AppTableData.tableColumns[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
