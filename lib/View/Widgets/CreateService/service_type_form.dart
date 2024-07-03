import 'package:flutter/material.dart';
import 'package:mmtransport/Components/Form-suggested/controller.dart';
import 'package:mmtransport/Components/Form-suggested/index.dart';
import 'package:mmtransport/Functions/is_paying_off.dart';
import 'package:mmtransport/Functions/validation_required_form.dart';

class ServiceTypeForm extends StatefulWidget {
  final TextFormWithSuggestedController controller;

  const ServiceTypeForm({super.key, required this.controller});

  @override
  State<ServiceTypeForm> createState() => _ServiceTypeFormState();
}

class _ServiceTypeFormState extends State<ServiceTypeForm> {
  @override
  void initState() {
    widget.controller.textController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPayingOff = isPayingOffServiceType(widget.controller.textFormValue);
    return CustomTextFormWithSuggestedValues(
      style: isPayingOff ? const TextStyle(color: Colors.red) : null,
      textFaildValidater: requiredFormValidation,
      hintText: "البضاعة",
      controller: widget.controller,
    );
  }
}
