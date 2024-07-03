import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomSecondaryyButton extends StatelessWidget {
  final Widget? child;
  final double topPadding;
  final double bottomPadding;
  final double height;
  final Color? color;
  final Color textColor;
  final Color? borderColor;
  final IconData icon;
  final String title;
  final double elevation;
  final void Function()? onPressed;

  const CustomSecondaryyButton({
    Key? key,
    this.onPressed,
    this.color,
    this.child,
    this.elevation = 2.0,
    this.height = 57,
    required this.title,
    this.textColor = Colors.white,
    this.borderColor,
    required this.icon,
    this.bottomPadding = 22,
    this.topPadding = 0.0,
  }) : super(key: key);

  BorderSide _border() {
    if (borderColor != null) return BorderSide(color: borderColor!);
    return BorderSide.none;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding, top: topPadding),
      child: MaterialButton(
        elevation: elevation,
        disabledColor: AppColors.gey,
        height: height,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: _border(),
        ),
        color: color ?? AppColors.secondColor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: child ??
            Row(
              textDirection: TextDirection.ltr,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      icon,
                      color: textColor,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
      ),
    );
  }
}
