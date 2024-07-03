import 'package:flutter/material.dart';

class InvoiceSearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final Function(String input) onChnage;

  const InvoiceSearchAppBar({
    Key? key,
    required this.controller,
    required this.onChnage,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  Widget clearButton() {
    bool initial = false;
    return StatefulBuilder(
      builder: (context, setState) {
        if (initial == false) {
          initial = true;
          controller.addListener(() => setState(() {}));
        }
        if (controller.text.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextButton(
              onPressed: () {
                controller.clear();
                onChnage("");
              },
              child: const Text("مسح", style: TextStyle(color: Colors.white)),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(color: Colors.green, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5.0,
            spreadRadius: 2.5,
            offset: const Offset(0.0, 3.0),
          ),
        ]),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.0),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              clearButton(),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: onChnage,
                  cursorColor: Colors.white30,
                  cursorWidth: 1.5,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Colors.white60),
                    hintText: "بحث عن الفواتير",
                    suffixIcon: Icon(
                      Icons.search_rounded,
                      color: Colors.white60,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
