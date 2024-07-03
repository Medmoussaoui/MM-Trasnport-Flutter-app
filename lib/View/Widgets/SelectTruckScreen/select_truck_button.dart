import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomSelectTruckItemButton extends StatefulWidget {
  final int groupValue;
  final bool loading;
  final void Function() ontap;
  const CustomSelectTruckItemButton({
    required this.ontap,
    required this.loading,
    required this.groupValue,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSelectTruckItemButton> createState() => _CustomSelectTruckItemButtonState();
}

class _CustomSelectTruckItemButtonState extends State<CustomSelectTruckItemButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> offsety;
  late Animation<double> opacity;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));

    offsety = Tween<double>(begin: 60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    )..addListener(() {
        setState(() {});
      });

    opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _showButton() {
    if (widget.groupValue == -1 && _controller.status == AnimationStatus.completed) {
      return _controller.reverse();
    }
    if (widget.groupValue != -1) _controller.forward();
  }

  Widget _child() {
    if (widget.loading) {
      return const CustomProgressIndicator();
    }
    return const CustomLargeTitle(
      title: "استمر",
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    _showButton();
    return Opacity(
      opacity: opacity.value,
      child: Transform.translate(
        offset: Offset(0.0, offsety.value),
        child: MaterialButton(
          onPressed: () {
            widget.ontap();
          },
          height: 60,
          minWidth: double.infinity,
          color: AppColors.secondColor,
          child: _child(),
        ),
      ),
    );
  }
}
