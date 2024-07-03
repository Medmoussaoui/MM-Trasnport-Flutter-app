import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';

class TableColumn extends StatefulWidget {
  final String columnName;
  final bool filterState;
  final int columnIndex;
  final Function(int columnIndex) onTap;

  const TableColumn({
    Key? key,
    required this.filterState,
    required this.columnIndex,
    required this.onTap,
    required this.columnName,
  }) : super(key: key);

  @override
  State<TableColumn> createState() => _TableColumnState();
}

class _TableColumnState extends State<TableColumn> {
  bool onTapEffect = false;

  Widget _filterIcon() {
    Icon icon = const Icon(Icons.filter_list, size: 12, color: Colors.white24);
    if (widget.filterState) {
      icon = const Icon(Icons.filter_alt, size: 12, color: Colors.white24);
    }
    return Align(
      alignment: Alignment.topRight,
      child: Padding(padding: const EdgeInsets.all(5), child: icon),
    );
  }

  void _runOnTapEffect() async {
    setState(() => onTapEffect = !onTapEffect);

    await Future.delayed(const Duration(milliseconds: 300));
    if (onTapEffect == false) return;
    _runOnTapEffect();
  }

  Color _columnColor() {
    if (onTapEffect) return AppColors.primaryColor.withOpacity(0.5);
    return AppColors.primaryColor.withOpacity(0.9);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _runOnTapEffect();
        widget.onTap(widget.columnIndex);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        height: 50,
        decoration: BoxDecoration(
          color: _columnColor(),
          border: Border.all(color: AppColors.geyDeep.withOpacity(0.5), width: 0.4),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                widget.columnName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            _filterIcon(),
          ],
        ),
      ),
    );
  }
}
