import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_no_internet_widget.dart';
import 'package:mmtransport/Components/custom_refrech_button.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_shimmer.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/controllers/TableInvoiceStore/index.dart';

class TableInvoicesStoreContentBody extends StatelessWidget {
  final ValueNotifier<StatusRequest> request;
  final Function refrechButton;

  const TableInvoicesStoreContentBody({
    super.key,
    required this.request,
    required this.refrechButton,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: request,
      builder: (context, StatusRequest value, child) {
        if (value.isLoading && value.hasData) return TableInvoicesStoreCustomBuildInvoices(request: request);
        if (value.isLoading) return _buildShimmerLoading();
        if (value.isSuccess && value.hasData) return TableInvoicesStoreCustomBuildInvoices(request: request);
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
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 240,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 20,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const InvoiceShimmerItem();
      },
    );
  }
}

class TableInvoicesStoreCustomBuildInvoices extends StatelessWidget {
  const TableInvoicesStoreCustomBuildInvoices({
    super.key,
    required this.request,
  });

  final ValueNotifier<StatusRequest> request;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TableInvoicesStoreScreenController>();
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 240,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 20,
      ),
      itemCount: (request.value.data as List).length,
      itemBuilder: (context, index) {
        final invoice = request.value.data[index] as Invoice;
        return Hero(
          tag: invoice.invoiceId.toString(),
          child: Material(
            child: CustomInvoiceCard(
              isSelect: controller.isInvoiceSelected,
              invoice: invoice,
              onLongPresss: controller.enableSelectMode,
              onSelect: controller.selectInvoice,
              selectMode: controller.selectMode,
              onPresss: controller.redirectToInvoicePreview,
            ),
          ),
        );
      },
    );
  }
}
