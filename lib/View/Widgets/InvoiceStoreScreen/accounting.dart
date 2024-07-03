import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';

class InvoiceCardTotaPayingOff extends StatelessWidget {
  final int payingOff;

  const InvoiceCardTotaPayingOff({
    required this.payingOff,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomLargeTitle(
          title: "$payingOff dh",
          color: Colors.red,
          size: 12,
        ),
        const Spacer(),
        const CustomLargeTitle(
          title: "مجموع الدفع",
          size: 10,
        ),
      ],
    );
  }
}

class InvoiceCardFinalTotal extends StatelessWidget {
  final int total;

  const InvoiceCardFinalTotal({
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomLargeTitle(
          title: "$total dh",
          color: Colors.green,
          size: 12,
        ),
        const Spacer(),
        const CustomLargeTitle(
          title: "المجموع",
          size: 10,
        ),
      ],
    );
  }
}
