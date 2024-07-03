import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/qr_code_scanner.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/FindInvoice/index.dart';

class FindInvoiceScreen extends StatelessWidget {
  const FindInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FindInvoiceScreenController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        title: const CustomLargeTitle(
          title: "البحث عن الفاتورة",
          color: Colors.white,
        ),
      ),
      body: ScannerWidget(
        bottomTitle: "قم بمسح الرمز الموجود على الفاتورة",
        bottomIcon: Icons.barcode_reader,
        onDetect: controller.onSacnBarCode,
      ),
    );
  }
}
