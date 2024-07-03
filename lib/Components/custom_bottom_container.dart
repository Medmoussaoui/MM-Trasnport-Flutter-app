import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomAnimatedBottomContainer extends StatefulWidget {
  /// default = Get.height * 0.13
  final double? height;
  final ValueNotifier<bool> visible;
  final Widget child;
  final Color? color;
  const CustomAnimatedBottomContainer({
    super.key,
    this.height,
    required this.visible,
    required this.child,
    this.color,
  });

  @override
  State<CustomAnimatedBottomContainer> createState() => _CustomAnimatedBottomContainerState();
}

class _CustomAnimatedBottomContainerState extends State<CustomAnimatedBottomContainer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _position;

  double _getHeight() {
    return widget.height ?? Get.height * 0.13;
  }

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    double h = _getHeight();
    _position = Tween<double>(begin: h, end: 0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  _onVisibleChange() {
    if (widget.visible.value) return controller.forward();
    if (!widget.visible.value) return controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.visible,
      builder: (_, value, child) {
        _onVisibleChange();
        return Transform.translate(
          offset: Offset(0.0, _position.value),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11.0),
            height: widget.height ?? Get.height * 0.11,
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: widget.child,
          ),
        );
      },
    );
  }
}
