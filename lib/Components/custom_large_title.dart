import 'package:flutter/material.dart';

class CustomLargeTitle extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;

  const CustomLargeTitle({Key? key, this.size, required this.title, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: color, fontSize: size),
    );
  }
}
