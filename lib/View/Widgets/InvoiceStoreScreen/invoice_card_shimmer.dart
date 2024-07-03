import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_shimmer_widget.dart';
import 'package:mmtransport/Constant/app.color.dart';

class InvoiceShimmerItem extends StatelessWidget {
  const InvoiceShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(children: const [
                    Expanded(
                      flex: 2,
                      child: CustomShimmerWidget.rectangle(height: 11, radius: 5),
                    ),
                    Spacer(),
                    Expanded(child: CustomShimmerWidget.rectangle(height: 20, radius: 5)),
                  ]),
                ),
                const Expanded(child: CustomShimmerWidget.rectangle(height: 50, radius: 10)),
              ],
            ),
          ),
          const InvoiceCardInfoShimmer(),
        ],
      ),
    );
  }
}

class InvoiceCardInfoShimmer extends StatelessWidget {
  const InvoiceCardInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5.0,
              spreadRadius: 2.5,
              offset: const Offset(0.0, -10),
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: const [
                  Expanded(flex: 2, child: CustomShimmerWidget.rectangle(height: 7, radius: 5)),
                  Spacer(),
                  Expanded(child: CustomShimmerWidget.rectangle(height: 7, radius: 5)),
                ],
              ),
            ),
            const Divider(color: AppColors.gey, height: 0.0),
            const Spacer(flex: 2),
            Row(
              children: const [
                Expanded(child: CustomShimmerWidget.rectangle(height: 8, radius: 5)),
                Spacer(),
                Expanded(flex: 2, child: CustomShimmerWidget.rectangle(height: 8, radius: 5)),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              children: const [
                Expanded(child: CustomShimmerWidget.rectangle(height: 8, radius: 5)),
                Spacer(),
                Expanded(flex: 2, child: CustomShimmerWidget.rectangle(height: 8, radius: 5)),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
