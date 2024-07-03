import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:mmtransport/Components/Form-suggested/controller.dart';
import 'package:mmtransport/Components/Form-suggested/suggested_values.dart';
import 'package:mmtransport/Components/custom_form_faild.dart';

class CustomTextFormWithSuggestedValues extends StatefulWidget {
  final TextFormWithSuggestedController controller;
  final String hintText;
  final TextStyle? style;
  final String? Function(String?)? textFaildValidater;

  const CustomTextFormWithSuggestedValues({
    this.textFaildValidater,
    Key? key,
    required this.hintText,
    required this.controller,
    this.style,
  }) : super(key: key);

  @override
  State<CustomTextFormWithSuggestedValues> createState() => _CustomTextFormWithSuggestedValuesState();
}

class _CustomTextFormWithSuggestedValuesState extends State<CustomTextFormWithSuggestedValues> {
  @override
  void initState() {
    widget.controller.initialLisener(setState);
    super.initState();
  }

  void _disableSuggestedValuesList(bool keyboardState) {
    if (widget.controller.showSuggestedList) {
      if (keyboardState == false) return widget.controller.disableSuggestedValues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormFaild(
          style: widget.style,
          validator: widget.textFaildValidater,
          controller: widget.controller.textController,
          textAlign: TextAlign.right,
          onTap: widget.controller.onFormTap,
          textDirection: TextDirection.rtl,
          hintText: widget.hintText,
          suffixIcon: widget.controller.showSuggestedList ? const Icon(Icons.arrow_drop_down) : null,
        ),
        // Test Drop Menu Item That conpare ther input value
        KeyboardVisibilityBuilder(
          builder: (context, isVisible) {
            _disableSuggestedValuesList(isVisible);
            return SuggestedValues(
              show: widget.controller.showSuggestedList,
              onSelect: widget.controller.selectSuggestedValue,
              statusRequest: widget.controller.statusRequest,
            );
          },
        ),
      ],
    );
  }
}
