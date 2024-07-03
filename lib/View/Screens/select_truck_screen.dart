import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/qr_code_scanner.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/View/Widgets/SelectTruckScreen/navigation_bar.dart';
import 'package:mmtransport/View/Widgets/SelectTruckScreen/select_trucks.dart';
import 'package:mmtransport/controllers/SelectTruck/index.dart';

class SelectTruckScreen extends StatelessWidget {
  const SelectTruckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SelectTruckScreenController());
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text("تحديد الشاحنة"),
      ),
      body: Obx(
        () {
          return AbsorbPointer(
            absorbing: controller.truckListController.onContinue.value,
            child: Column(
              children: [
                CustomSelectTruckNavigationTap(
                  groupValue: controller.curretScreen.value,
                  onSelect: controller.navigate,
                ),
                Expanded(
                  child: Opacity(
                    opacity: controller.truckListController.onContinue.value ? 0.5 : 1.0,
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller.pageViewController,
                      children: [
                        CustomSelectTruckList(controller: controller.truckListController),
                        ScannerWidget(
                          bottomTitle: "قم بمسح الرمز الموجود على الشاحنة",
                          bottomIcon: Icons.qr_code_scanner_rounded,
                          onDetect: (code) {
                            controller.scannerController.detect(code);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
