import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/custom_app_bar.dart';
import 'package:mmtransport/Components/Table/index.dart';
import 'package:mmtransport/View/Widgets/TableScreen/custom_app_bar.dart';
import 'package:mmtransport/View/Widgets/TableScreen/custom_floating_action_button.dart';
import 'package:mmtransport/controllers/TableScreen/index.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TableScreenController());
    return Scaffold(
      appBar: CustomTableDataAppBarSelectMode(
        controller: controller.tableDataController,
        appBar: const CustomtTableScreenAppBar(),
      ),
      floatingActionButton: const CustomTableScreenFloatingActionButton(),
      body: TableDataWidget(controller: controller.tableDataController),
    );
  }
}
