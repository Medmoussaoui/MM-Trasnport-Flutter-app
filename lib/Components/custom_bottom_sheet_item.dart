import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomBottomSheetItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool active;
  final void Function() onTap;

  const CustomBottomSheetItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = Colors.black87,
    this.active = true,
  }) : super(key: key);

  @override
  State<CustomBottomSheetItem> createState() => _CustomBottomSheetItemState();
}

class _CustomBottomSheetItemState extends State<CustomBottomSheetItem> {
  bool clickEffect = false;

  runClickEffect() async {
    setState(() => clickEffect = true);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => clickEffect = false);
  }

  _onTap() async {
    if (widget.active) {
      await runClickEffect();
      widget.onTap();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.active ? 1.0 : 0.4,
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: clickEffect ? AppColors.gey.withOpacity(0.5) : Colors.white,
            border: Border.all(color: AppColors.gey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 24, color: widget.color),
              const Spacer(),
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
