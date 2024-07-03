import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/Functions/dates.dart';
import 'package:mmtransport/View/Widgets/InvoiceScreen/total.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_table_header.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_table_row.dart';
import 'package:barcode_widget/barcode_widget.dart';

class CustomInvoicePreview extends StatefulWidget {
  final ValueNotifier<bool> refrech;
  const CustomInvoicePreview({
    super.key,
    required this.refrech,
    required this.invoice,
  });

  final Invoice invoice;

  @override
  State<CustomInvoicePreview> createState() => _CustomInvoicePreviewState();
}

class _CustomInvoicePreviewState extends State<CustomInvoicePreview> {
  bool shrink = true;

  Widget _totalSummary() {
    if (shrink) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: CustomInvoicePreviewTotalSummary(invoice: widget.invoice),
    );
  }

  Widget showAllButton() {
    if (!shrink) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () {
        shrink = !shrink;
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2.5,
              offset: const Offset(0.0, -5.0),
            ),
          ],
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        child: Row(
          children: const [
            Icon(Icons.expand_more_rounded, color: AppColors.secondColor),
            Spacer(),
            Text(
              "عرض الكل",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.refrech,
      builder: (_, value, child) {
        Invoice invoice = widget.invoice;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 5.0,
                        spreadRadius: 2.5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      InvoiceCustomDateAndTruckPicture(date: invoice.dateCreate!),
                      InvoiceCustomNameAndBarCode(invoice: invoice),
                      CustomInvoiceStateText(invoice: invoice),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 47,
                        child: const InvoiceCardTableHeader(
                          padding: EdgeInsets.all(11.0),
                          radius: 5.0,
                        ),
                      ),
                      CustomInvoiceRows(invoice: invoice, shrink: shrink),
                      // total Summary
                      _totalSummary(),
                    ],
                  ),
                ),
              ),
              showAllButton(),
            ],
          ),
        );
      },
    );
  }
}

class CustomInvoiceStateText extends StatelessWidget {
  final Invoice invoice;

  const CustomInvoiceStateText({
    required this.invoice,
    super.key,
  });

  Widget _state() {
    if (invoice.payStatus == "paid") {
      return const Text(
        "مدفوعة",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14.5,
          color: Colors.blue,
        ),
      );
    }
    return const Text(
      "غير مدفوعة",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14.5,
        color: Colors.orange,
      ),
    );
  }

  Widget _paidDate() {
    if (invoice.payStatus == "unpaid") return const SizedBox.shrink();
    if (invoice.padiDate == null) return const SizedBox.shrink();
    String paidDate = getDate(invoice.padiDate!);
    return Text(
      "( $paidDate )",
      style: const TextStyle(
        //fontWeight: FontWeight.w500,
        fontSize: 14.5,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
      child: Row(
        children: [
          const Spacer(),
          _paidDate(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _state(),
          ),
          const Text(
            "حالة الفاتورة ",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInvoiceRows extends StatelessWidget {
  const CustomInvoiceRows({
    super.key,
    required this.invoice,
    required this.shrink,
  });

  final bool shrink;
  final Invoice invoice;

  int _itemCount() {
    if (shrink && invoice.services!.length > 2) {
      return 2;
    }
    return invoice.services!.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(5),
        ),
      ),
      child: ListView.builder(
        itemCount: _itemCount(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          return InvoiceCardTableRow(
            heigth: 35,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            service: invoice.services![index],
          );
        },
      ),
    );
  }
}

class InvoiceCustomDateAndTruckPicture extends StatelessWidget {
  final String date;

  const InvoiceCustomDateAndTruckPicture({
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      child: Row(
        children: [
          Text(
            getDate(date),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
          ),
          const Spacer(),
          Image.asset(
            AppImages.truck,
            height: 50,
          )
        ],
      ),
    );
  }
}

class InvoiceCustomNameAndBarCode extends StatelessWidget {
  final Invoice invoice;

  const InvoiceCustomNameAndBarCode({
    required this.invoice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      color: AppColors.secondColor,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            width: Get.width * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: BarcodeWidget(
                data: "IV${invoice.invoiceId}",
                barcode: Barcode.code128(),
                drawText: false,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          const Spacer(),
          CustomLargeTitle(
            color: Colors.white,
            title: invoice.invoiceName ?? "#${invoice.invoiceId}",
            size: 16,
          ),
        ],
      ),
    );
  }
}
