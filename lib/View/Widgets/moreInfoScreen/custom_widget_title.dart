import 'package:flutter/cupertino.dart';

class CustomWidgetTitle extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final TextStyle? style;

  const CustomWidgetTitle({
    super.key,
    this.fontSize,
    this.padding,
    this.style,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = style ?? TextStyle(fontSize: fontSize ?? 18);
    textStyle = textStyle.copyWith(fontSize: textStyle.fontSize ?? 18);

    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 15, bottom: 10),
      child: Text(title, style: textStyle),
    );
  }
}
