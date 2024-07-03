import 'package:flutter/material.dart';

class CustomNavigationTapItem extends StatelessWidget {
  final int value;
  final double? radius;
  final int groupValue;
  final IconData? icon;
  final Color? selectColor;
  final Color? selectFillColor;
  final Color? unSelectColor;
  final String title;
  final void Function(int value)? onTap;

  const CustomNavigationTapItem({
    Key? key,
    required this.groupValue,
    required this.value,
    this.icon,
    this.onTap,
    this.selectColor,
    this.radius,
    this.selectFillColor,
    this.unSelectColor,
    required this.title,
  }) : super(key: key);

  bool _isSelect() {
    return groupValue == value;
  }

  TextStyle _textStyle() {
    return TextStyle(
      fontSize: 16,
      color: _color(),
    );
  }

  Color _color() {
    if (_isSelect()) return selectColor ?? Colors.black87;
    return unSelectColor ?? Colors.white.withOpacity(0.8);
  }

  Widget _rowTitleWithIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: _color()),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              child: Text(
                title,
                style: _textStyle(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _child() {
    if (icon == null) {
      return Center(
        child: FittedBox(
          child: Text(
            title,
            style: _textStyle(),
          ),
        ),
      );
    }
    return _rowTitleWithIcon();
  }

  Color _borderColor() {
    Color color = selectFillColor ?? Colors.white;
    if (_isSelect()) return color;
    return color.withOpacity(0.5);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: _isSelect() ? selectFillColor ?? Colors.white : null,
          borderRadius: BorderRadius.circular(radius ?? 7),
          border: Border.all(color: _borderColor()),
        ),
        child: _child(),
      ),
    );
  }
}
