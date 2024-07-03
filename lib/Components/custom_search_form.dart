import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/class/api_connection.dart';

class CustomSearchForm extends StatefulWidget {
  final TextEditingController? controller;
  final ValueNotifier<StatusRequest> request;
  final void Function(String input) onChange;
  final void Function(String input) onClear;
  final void Function()? onTap;
  final String hintText;

  const CustomSearchForm({
    this.controller,
    this.onTap,
    required this.hintText,
    required this.onChange,
    required this.request,
    required this.onClear,
    super.key,
  });

  @override
  State<CustomSearchForm> createState() => _CustomSearchFormState();
}

class _CustomSearchFormState extends State<CustomSearchForm> {
  late TextEditingController controller;
  Widget _leftWidget() {
    if (widget.request.value.isLoading) {
      return const Center(child: CustomProgressIndicator(color: AppColors.primaryColor));
    }

    if (controller.text.isNotEmpty) {
      return GestureDetector(
        onTap: () => _clearFormInput(),
        child: const Icon(
          Icons.close,
          size: 20,
          color: AppColors.geyDeep,
        ),
      );
    }

    return const Icon(Icons.search_rounded, color: AppColors.geyDeep);
  }

  void _clearFormInput() {
    widget.onClear("");
    isFormEmpty = true;
    setState(() {});
  }

  void enableForm() {
    isFormActive = true;
    setState(() {});
  }

  void disableForm() {
    isFormActive = false;
    setState(() {});
  }

  bool isFormActive = false;
  bool isFormEmpty = true;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.request,
      builder: (_, value, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.gey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isFormActive ? AppColors.primaryColor : AppColors.gey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _leftWidget(),
              Expanded(
                child: TextField(
                  textAlign: TextAlign.right,
                  textAlignVertical: TextAlignVertical.bottom,
                  controller: controller,
                  onTap: () {
                    enableForm();
                    if (widget.onTap != null) widget.onTap!();
                  },
                  onSubmitted: (input) {
                    disableForm();
                  },
                  onChanged: (input) {
                    widget.onChange(input);
                    if (input.isNotEmpty && isFormEmpty) {
                      isFormEmpty = false;
                      setState(() {});
                    }
                    if (input.isEmpty && !isFormEmpty) {
                      isFormEmpty = true;
                      setState(() {});
                    }
                    widget.onChange(input);
                  },
                  textDirection: TextDirection.rtl,
                  cursorHeight: 25,
                  cursorRadius: const Radius.circular(5),
                  cursorColor: AppColors.primaryColor,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: AppColors.geyDeep, fontSize: 14),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
