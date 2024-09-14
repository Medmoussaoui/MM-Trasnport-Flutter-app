import 'package:flutter/material.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomTextFormFaild extends StatefulWidget {
  final String hintText;
  final bool isSecure;
  final TextAlign textAlign;
  final void Function()? onTap;
  final IconData? icon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool? enable;
  final bool? filled;
  final Color? filledColor;
  final String? initialValue;
  final TextDirection textDirection;
  final String? Function(String? input)? validator;
  final bool? autofocus;
  final TextStyle? style;

  const CustomTextFormFaild({
    Key? key,
    this.controller,
    this.onTap,
    this.prefixWidget,
    this.suffixIcon,
    this.autofocus,
    this.filledColor,
    this.style,
    this.textDirection = TextDirection.ltr,
    this.filled,
    this.textAlign = TextAlign.start,
    this.initialValue,
    required this.hintText,
    this.isSecure = false,
    this.enable,
    this.validator,
    this.icon,
  }) : super(key: key);

  @override
  State<CustomTextFormFaild> createState() => _CustomTextFormFaildState();
}

class _CustomTextFormFaildState extends State<CustomTextFormFaild> {
  bool showPassword = false;
  bool isSaved = false;
  String input = "";

  Widget? _visiblePassword() {
    if (widget.isSecure) {
      return InkWell(
        borderRadius: BorderRadius.circular(200),
        onTap: () {
          setState(() {
            showPassword = !showPassword;
          });
        },
        child: Icon(
          showPassword ? Icons.visibility_off : Icons.visibility,
          size: 22,
        ),
      );
    }
    return null;
  }

  Widget? _prefixIcon() {
    if (widget.prefixWidget != null) return widget.prefixWidget;
    if (widget.icon == null && widget.isSecure) {
      return _visiblePassword();
    }
    if (widget.isSecure && input.isNotEmpty) {
      return _visiblePassword();
    }

    return widget.icon == null ? null : Icon(widget.icon, size: 24);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection,
      child: TextFormField(
        style: widget.style,
        autofocus: widget.autofocus ?? false,
        textAlign: widget.textAlign,
        initialValue: widget.initialValue,
        controller: widget.controller,
        validator: widget.validator,
        enabled: widget.enable,
        onTap: widget.onTap,
        onChanged: (value) {
          input = value;
          setState(() {});
        },
        onSaved: (input) {
          if (!isSaved) {
            setState(() => isSaved = true);
          }
        },
        obscureText: widget.isSecure && !showPassword,
        autovalidateMode: isSaved ? AutovalidateMode.always : null,
        cursorHeight: 20,
        cursorColor: AppColors.primaryColor,
        obscuringCharacter: "●",
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 5.0, right: 10, left: 10),
          filled: widget.filled ?? true,
          fillColor: widget.filledColor ?? AppColors.gey.withOpacity(0.15),
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0.5,
              color: AppColors.geyDeep,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.secondColor.withOpacity(0.9),
            ),
          ),
          prefixIconColor: AppColors.primaryColor,
          prefixIcon: _prefixIcon(),
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
