import 'package:flutter/cupertino.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';

class SuggestedValueItem extends StatefulWidget {
  final String value;
  final Function(String value)? onTap;

  const SuggestedValueItem({
    this.onTap,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  State<SuggestedValueItem> createState() => _SuggestedValueItemState();
}

class _SuggestedValueItemState extends State<SuggestedValueItem> {
  bool clickEffect = false;

  runClickEffect() async {
    setState(() => clickEffect = true);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => clickEffect = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await runClickEffect();
        if (widget.onTap != null) widget.onTap!(widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        alignment: Alignment.centerRight,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        decoration: BoxDecoration(
          color: clickEffect ? AppColors.secondColor.withOpacity(0.2) : null,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: CustomLargeTitle(
          title: widget.value,
          size: 16,
          color: AppColors.secondColor,
        ),
      ),
    );
  }
}
