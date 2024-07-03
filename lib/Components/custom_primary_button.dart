import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String buttonText;
  final double? elevation;
  final Widget? child;
  final double topPadding;
  final double bottomPadding;
  final double height;
  final Color? color;
  final Color textColor;
  final double borderRadius;
  final void Function()? onPressed;

  const CustomPrimaryButton({
    Key? key,
    this.onPressed,
    this.child,
    this.color,
    this.elevation,
    this.height = 57,
    this.textColor = Colors.white,
    this.bottomPadding = 22,
    this.topPadding = 0.0,
    this.buttonText = 'untitled',
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding, top: topPadding),
      child: MaterialButton(
        elevation: elevation,
        disabledColor: AppColors.gey,
        height: height,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        color: color ?? AppColors.secondColor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Center(
          child: child ??
              Text(
                buttonText,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
              ),
        ),
      ),
    );
  }
}
