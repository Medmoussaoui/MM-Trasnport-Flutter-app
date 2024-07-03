import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/custom_no_internet_widget.dart';
import 'package:mmtransport/Components/custom_progress_indicator.dart';
import 'package:mmtransport/Components/custom_refrech_button.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/Constant/app.images.dart';
import 'package:mmtransport/Data/entitys/invoice.entity.dart';
import 'package:mmtransport/View/Widgets/InvoiceSearchScreen/default_body.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card.dart';
import 'package:mmtransport/View/Widgets/InvoiceStoreScreen/invoice_card_shimmer.dart';
import 'package:mmtransport/class/api_connection.dart';
import 'package:mmtransport/controllers/invoice_search_screen_controller.dart';

class InvoiceSearchContentBody extends StatelessWidget {
  const InvoiceSearchContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InvoiceSearchScreenController>();
    return ValueListenableBuilder(
      valueListenable: controller.searchRequest,
      builder: (context, StatusRequest value, child) {
        if (value.isNone) {
          return const InvoiceSearchCustomDefaultBody();
        }
        if (value.isSuccess && value.hasData) {
          return InvoiceSearchBuildInvoices(controller: controller);
        }
        if (value.isLoading) {
          return _buildShimmerLoading();
        }
        if (value.isConnectionError) {
          return InvoiceSearchNoInteretWidget(
            refrech: controller.refrechButton,
          );
        }
        return const InvoiceSearchNoInvoicesWidget();
      },
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 240,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return const InvoiceShimmerItem();
        },
        itemCount: 4,
      ),
    );
  }
}

class InvoiceSearchNoInteretWidget extends StatelessWidget {
  final Function refrech;
  const InvoiceSearchNoInteretWidget({
    super.key,
    required this.refrech,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CustomNoInternetWidget(),
          const SizedBox(height: 12),
          CustomRefrechButton(
            onPressed: () => refrech(),
          ),
        ],
      ),
    );
  }
}

class InvoiceSearchNoInvoicesWidget extends StatelessWidget {
  const InvoiceSearchNoInvoicesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
        ],
      ),
    );
  }
}

class InvoiceSearchBuildInvoices extends StatelessWidget {
  final InvoiceSearchScreenController controller;

  const InvoiceSearchBuildInvoices({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final List<Invoice> invoices = controller.searchRequest.value.data;
    return ListView(
      controller: controller.scrollController,
      children: [
        GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 240,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 20,
          ),
          itemCount: invoices.length,
          itemBuilder: (context, index) {
            return Hero(
              tag: invoices[index].invoiceId.toString(),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: EdgeInsets.only(top: (index == 0 || index == 1) ? 15 : 0),
                  child: CustomInvoiceCard(
                    invoice: invoices[index],
                    onPresss: controller.redirectToInvoicePreview,
                    onSelect: (invoice) => null,
                    onLongPresss: (invoice) => null,
                    selectMode: ValueNotifier(false),
                    isSelect: (invoice) => false,
                  ),
                ),
              ),
            );
          },
        ),
        Center(
          child: InvoiceSearchBottomProgressLoading(
            onLoad: controller.onLoad,
            isEnd: controller.pageIndex.value == -1,
          ),
        ),
      ],
    );
  }
}

class InvoiceSearchBottomProgressLoading extends StatelessWidget {
  const InvoiceSearchBottomProgressLoading({
    super.key,
    required this.onLoad,
    required this.isEnd,
  });

  final RxBool onLoad;
  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (onLoad.value) {
          return const Padding(
            padding: EdgeInsets.all(10),
            child: CustomProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }
        if (isEnd) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("النهاية"),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
