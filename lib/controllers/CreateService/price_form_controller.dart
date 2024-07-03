import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_keyboard_number.dart';
import 'package:mmtransport/Functions/show_bottom_sheet.dart';

class PriceFormController {
  Color color = Colors.black87;

  PriceFormController(String? initialValue) {
    price.value = initialValue ?? "0.0";
  }

  RxString price = "0.0".obs;
  ValueNotifier<bool> priceValidState = ValueNotifier(true);

  bool validate() {
    bool isValid = price.value.isNotEmpty && price.value != "0.0";
    if (isValid) {
      priceValidState.value = true;
      return true;
    }
    priceValidState.value = false;
    return false;
  }

  void defaultState() {
    price.value = "0.0";
    priceValidState.value = true;
  }

  void enterPrice(String input) {
    price.value = input;
  }

  void onTap() {
    if (!priceValidState.value) defaultState();
    showKeyboardNumber();
  }

  void showKeyboardNumber() {
    customShowBottoSheet(
      CustomKeyboardNumber(onChange: enterPrice),
    );
  }
}
