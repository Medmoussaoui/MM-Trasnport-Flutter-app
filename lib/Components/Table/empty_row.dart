import 'package:flutter/widgets.dart';
import 'package:mmtransport/Constant/app.color.dart';

class TableEmptyRow extends StatelessWidget {
  const TableEmptyRow({super.key});

  Widget _row() {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.geyDeep.withOpacity(0.5),
          width: 0.4,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (index) => Expanded(child: _row()),
      ),
    );
  }
}
