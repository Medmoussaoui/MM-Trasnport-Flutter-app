import 'package:flutter/cupertino.dart';
import 'package:mmtransport/Components/Table/Controller/filter_rows.dart';
import 'package:mmtransport/Components/Table/FilterBottomSheet/filter_item.dart';

class FilterValuesListBuilder extends StatelessWidget {
  final TableFilterController controller;
  const FilterValuesListBuilder({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final values = controller.currentColumn.columnValues.toList();
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        return FilterItemValue(
          controller: controller,
          value: values[index],
        );
      },
    );
  }
}
