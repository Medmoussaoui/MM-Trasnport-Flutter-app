import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_search_form.dart';
import 'package:mmtransport/class/api_connection.dart';

class CustomFolderSearchForm extends StatelessWidget {
  final TextEditingController? controller;
  final ValueNotifier<StatusRequest> searchRequest;
  final void Function(String input) onChange;
  final void Function(String input) onClear;

  const CustomFolderSearchForm({
    super.key,
    this.controller,
    required this.onChange,
    required this.searchRequest,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      height: 100,
      width: double.infinity,
      child: CustomSearchForm(
        hintText: "البحث عن الجداول",
        controller: controller,
        request: searchRequest,
        onChange: onChange,
        onClear: onClear,
      ),
    );
  }
}
