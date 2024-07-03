import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/custom_app_bar.dart';
import 'package:mmtransport/Components/Table/index.dart';
import 'package:mmtransport/Components/Table/table_floating_action_button.dart';
import 'package:mmtransport/View/Widgets/homeScreen/custom_app_bar.dart';
import 'package:mmtransport/controllers/HomePage/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return Scaffold(
      floatingActionButton: TableFloatingActionButton(
        controller: controller.tableDataController,
        onPressToAdd: () => controller.createNewService(),
        onPressWithSelectMode: () => controller.showSelectBottomSheet(),
      ),
      appBar: CustomTableDataAppBarSelectMode(
        controller: controller.tableDataController,
        appBar: const CustomHomeScreenAppBar(),
      ),
      body: TableDataWidget(controller: controller.tableDataController),
    );
  }
  
}

class ServiceData {
  final String boatName;
  final String serviceType;
  final String price;
  final String date;

  ServiceData(this.boatName, this.serviceType, this.price, this.date);
}
