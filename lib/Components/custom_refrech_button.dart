import 'package:flutter/material.dart';

class CustomRefrechButton extends StatelessWidget {
  const CustomRefrechButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 50,
      height: 50,
      color: Colors.white,
      shape: const CircleBorder(),
      child: const Icon(Icons.refresh, size: 35, color: Colors.grey),
      onPressed: () => onPressed(),
    );
  }
}
