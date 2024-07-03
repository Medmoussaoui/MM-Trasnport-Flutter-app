import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:printing/printing.dart';

class PdfPagePreview extends StatelessWidget {
  final Uint8List ourPdf;
  final String pdfName;
  const PdfPagePreview({super.key, required this.ourPdf, required this.pdfName});

  runShare() async {
    await Printing.sharePdf(
      bytes: ourPdf,
      filename: pdfName,
    );
  }

  @override
  Widget build(BuildContext context) {
    runShare();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.black),
        backgroundColor: Colors.white,
        elevation: 1.5,
        title: const CustomLargeTitle(title: "الفاتورة"),
        centerTitle: true,
      ),
      body: PdfPreview(
        pdfFileName: pdfName,
        canChangeOrientation: false,
        allowSharing: true,
        canChangePageFormat: false,
        canDebug: false,
        build: (context) => ourPdf,
      ),
    );
  }
}
