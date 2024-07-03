import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/class/api_connection.dart';

class InvoiceStoreLoadingInvoices extends StatelessWidget {
  const InvoiceStoreLoadingInvoices({
    super.key,
    required this.request,
    required this.onEnd,
  });

  final bool Function() onEnd;
  final ValueNotifier<StatusRequest> request;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: request,
      builder: (context, StatusRequest value, child) {
        if (value.isLoading && value.hasData) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CustomProgressIndicator(color: AppColors.primaryColor)),
          );
        }

        if (onEnd()) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text("النهاية"),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
