import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/View/Widgets/InvoiceSearchScreen/app_bar.dart';
import 'package:mmtransport/View/Widgets/InvoiceSearchScreen/search_builder.dart';
import 'package:mmtransport/controllers/invoice_search_screen_controller.dart';

class InvoiceSearchScreen extends StatelessWidget {
  const InvoiceSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceSearchScreenController());
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: InvoiceSearchAppBar(
        controller: controller.formController,
        onChnage: (input) => controller.findInvoiceByName(input),
      ),
      body: WillPopScope(
        onWillPop: () async {
          controller.defaultMode();
          return true;
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: InvoiceSearchContentBody(),
        ),
      ),
    );
  }
}
