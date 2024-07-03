import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_no_internet_widget.dart';
import 'package:mmtransport/Components/custom_refrech_button.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/build_table_invoices.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_shimmer.dart';
import 'package:mmtransport/class/api_connection.dart';

class InvoiceStoreContentBody extends StatelessWidget {
  final ValueNotifier<StatusRequest> request;
  final Function refrechButton;

  const InvoiceStoreContentBody({
    super.key,
    required this.request,
    required this.refrechButton,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: request,
      builder: (context, StatusRequest value, child) {
        if (value.isLoading && value.hasData) return CustomSliverBuildTableInvoices(request: request);
        if (value.isLoading) return _buildShimmerLoading();
        if (value.isSuccess && value.hasData) return CustomSliverBuildTableInvoices(request: request);
        if (value.isConnectionError) return _noInternet();
        return _noInvoices();
      },
    );
  }

  _noInternet() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Get.height * 0.65,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomNoInternetWidget(),
              const SizedBox(height: 12),
              CustomRefrechButton(
                onPressed: () => refrechButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _noInvoices() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Get.height * .7,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImages.empty, width: 80),
              const SizedBox(height: 12),
              CustomLargeTitle(
                title: "لاتوجد فواتير حاليا",
                size: 15.0,
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
              const SizedBox(height: 12),
              CustomRefrechButton(
                onPressed: () => refrechButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 240,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return const InvoiceShimmerItem();
              },
              itemCount: 2,
            ),
          );
        },
        childCount: 2,
      ),
    );
  }
}

class CustomSliverBuildTableInvoices extends StatelessWidget {
  const CustomSliverBuildTableInvoices({
    super.key,
    required this.request,
  });

  final ValueNotifier<StatusRequest> request;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return BuildTableInvoices(
            tableInvoices: request.value.data[index],
          );
        },
        childCount: (request.value.data as List).length,
      ),
    );
  }
}
