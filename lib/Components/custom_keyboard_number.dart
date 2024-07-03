import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_bottom_sheet_slider.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';

class CustomKeyboardNumber extends StatefulWidget {
  final Function(String input) onChange;

  const CustomKeyboardNumber({Key? key, required this.onChange}) : super(key: key);

  @override
  State<CustomKeyboardNumber> createState() => _CustomKeyboardNumberState();
}

class _CustomKeyboardNumberState extends State<CustomKeyboardNumber> {
  String input = "";

  _onNumberTap(String value) {
    input += value;
    if (input == "0") return input = "";
    widget.onChange(input);
  }

  _onBackSpaceTap() {
    if (input.isEmpty) return widget.onChange(input);
    String sub = input.substring(0, (input.length - 1));
    input = sub;
    widget.onChange(input);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: (Get.height / 2.1),
        padding: const EdgeInsets.symmetric(horizontal: 45),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            const CustomBottomSheetSlider(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => KeyboardNumberItem(
                  onTap: _onNumberTap,
                  number: (index + 1).toString(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => KeyboardNumberItem(
                  onTap: _onNumberTap,
                  number: (4 + index).toString(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => KeyboardNumberItem(
                  onTap: _onNumberTap,
                  number: (7 + index).toString(),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: KeyboardNumberItem(onTap: _onNumberTap, number: ","),
                ),
                Expanded(
                  child: Center(
                    child: KeyboardNumberItem(onTap: _onNumberTap, number: "0"),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: KeyboardIconItem(
                      onTap: _onBackSpaceTap,
                      icon: Icons.backspace_outlined,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class KeyboardNumberItem extends StatefulWidget {
  final void Function(String value) onTap;
  final String number;

  const KeyboardNumberItem({
    Key? key,
    required this.onTap,
    required this.number,
  }) : super(key: key);

  @override
  State<KeyboardNumberItem> createState() => _KeyboardNumberItemState();
}

class _KeyboardNumberItemState extends State<KeyboardNumberItem> {
  bool clickEffect = false;

  runClickEffect() async {
    widget.onTap(widget.number);

    setState(() => clickEffect = true);
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() => clickEffect = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        runClickEffect();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: clickEffect ? AppColors.gey : null,
          shape: BoxShape.circle,
        ),
        child: CustomLargeTitle(
          title: widget.number,
          size: 30,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class KeyboardIconItem extends StatefulWidget {
  final void Function() onTap;
  final IconData icon;

  const KeyboardIconItem({
    Key? key,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  State<KeyboardIconItem> createState() => _KeyboardIconItemState();
}

class _KeyboardIconItemState extends State<KeyboardIconItem> {
  bool clickEffect = false;

  runClickEffect() async {
    widget.onTap();
    setState(() => clickEffect = true);
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => clickEffect = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        runClickEffect();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: clickEffect ? AppColors.gey : null,
          shape: BoxShape.circle,
        ),
        child: Icon(
          widget.icon,
          color: Colors.black87,
        ),
      ),
    );
  }
}
