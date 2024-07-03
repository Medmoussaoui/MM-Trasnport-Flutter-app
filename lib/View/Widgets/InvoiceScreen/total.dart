import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';

class CustomInvoicePreviewTotalSummary extends StatelessWidget {
  final Invoice invoice;

  const CustomInvoicePreviewTotalSummary({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomInvoicePreviewTotalPayingOff(invoice: invoice),
        CustomInvoicePreviewTotal(invoice: invoice),
      ],
    );
  }
}

class CustomInvoicePreviewTotal extends StatelessWidget {
  final Invoice invoice;

  const CustomInvoicePreviewTotal({
    required this.invoice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor, width: 0.5),
                color: AppColors.gey.withOpacity(0.2),
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5)),
              ),
              child: Center(
                child: FittedBox(
                  child: Row(
                    children: [
                      const CustomLargeTitle(
                        title: "درهم",
                        size: 15.0,
                      ),
                      CustomLargeTitle(
                        title: " ${invoice.finalTotal}",
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 47,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: const FittedBox(
                child: Text(
                  "المجموع",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInvoicePreviewTotalPayingOff extends StatelessWidget {
  final Invoice invoice;

  const CustomInvoicePreviewTotalPayingOff({
    required this.invoice,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 47,
              decoration: BoxDecoration(
                color: AppColors.gey.withOpacity(0.2),
                border: Border.all(color: AppColors.primaryColor, width: 0.5),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(5)),
              ),
              child: Center(
                child: FittedBox(
                  child: Row(
                    children: [
                      const CustomLargeTitle(
                        title: "درهم",
                        size: 15.0,
                        color: Colors.red,
                      ),
                      CustomLargeTitle(
                        title: " -${invoice.totalPayingOff}",
                        size: 15.0,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 47,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                ),
              ),
              child: const FittedBox(
                child: Text(
                  "مجموع الدفع",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
