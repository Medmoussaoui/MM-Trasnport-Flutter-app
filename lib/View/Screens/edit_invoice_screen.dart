import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/custom_app_bar.dart';
import 'package:mmtransport/Components/Table/index.dart';
import 'package:mmtransport/Components/Table/table_floating_action_button.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/device_connection_state_widget.dart';
import 'package:mmtransport/controllers/InvoiceEditScreen/index.dart';

class InvoiceEditScreen extends StatelessWidget {
  const InvoiceEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InvoiceEditScreenController());
    return Scaffold(
      floatingActionButton: TableFloatingActionButton(
        controller: controller.tableDataController,
        onPressToAdd: () {
          controller.createNewService();
        },
        onPressWithSelectMode: () {
          controller.showTableSelectBottomSheet();
        },
      ),
      appBar: CustomTableDataAppBarSelectMode(
        controller: controller.tableDataController,
        appBar: AppBar(
          elevation: 0.5,
          centerTitle: true,
          title: CustomLargeTitle(
            title: "#00${controller.invoice.invoiceId}",
            color: Colors.white,
          ),
          actions: const [
            DeviceConnectionStateWidget(),
            SizedBox(width: 20),
          ],
        ),
      ),
      body: TableDataWidget(controller: controller.tableDataController),
    );
  }
}
