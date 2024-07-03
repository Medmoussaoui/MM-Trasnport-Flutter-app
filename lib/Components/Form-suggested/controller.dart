import 'package:flutter/cupertino.dart';
import 'package:mmtransport/Functions/check_connectivity.dart';
import 'package:mmtransport/class/api_connection.dart';

abstract class TextFormWithSuggestedController {
  String? initialValue;

  TextFormWithSuggestedController(this.initialValue) {
    textController = TextEditingController(text: initialValue);
  }

  late final TextEditingController textController;
  late final void Function() update;
  StatusRequest statusRequest = StatusRequest();

  String textFormValue = "";
  bool showSuggestedList = false;

  void enableSuggestedValues() => showSuggestedList = true;
  void disableSuggestedValues() => showSuggestedList = false;

  /// To custom Implementation
  Future<StatusRequest> fetchSuggestedValuesLocal();
  Future<StatusRequest> fetchSuggestedValuesRemote();

  Future<StatusRequest> _fetchLocaly() async {
    return fetchSuggestedValuesLocal();
  }

  Future<StatusRequest> _fetchRemotly() async {
    return fetchSuggestedValuesRemote();
  }

  Future<void> getSuggestedValues() async {
    statusRequest.loading();
    update();

    await Future.delayed(const Duration(milliseconds: 500)); // TEST
    bool hasConnection = await hasInternet();

    if (hasConnection) {
      statusRequest = await _fetchRemotly();
      if (statusRequest.isSuccess) return update();
    }

    statusRequest = await _fetchLocaly();
    update();
  }

  void selectSuggestedValue(String value) {
    textFormValue = value;
    textController.text = value;
    disableSuggestedValues();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void onFormTap() {
    enableSuggestedValues();
  }

  Future<void> onFormWrite() async {
    if (textController.text.isEmpty) {
      textFormValue = "";
      return disableSuggestedValues();
    }
    if (textFormValue == textController.text) return;
    enableSuggestedValues();
    textFormValue = textController.text;
    await getSuggestedValues();
  }

  void initialLisener(void Function(void Function() fn) setState) {
    update = () {
      setState(() => {});
    };

    textController.addListener(() async {
      await onFormWrite();
      textController.selection = TextSelection.fromPosition(TextPosition(offset: textController.text.length));
    });
  }

  void dispose() {
    textController.dispose();
  }
}
