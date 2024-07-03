import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/View/Widgets/moreInfoScreen/custom_truck_info.dart';
import 'package:mmtransport/View/Widgets/moreInfoScreen/custom_widget_title.dart';
import 'package:mmtransport/View/Widgets/moreInfoScreen/short_service_table.dart';
import 'package:mmtransport/controllers/service_more_info_screen_controler.dart';

import '../Widgets/moreInfoScreen/custom_note.dart';

class ServiceModeInfoScreen extends StatelessWidget {
  const ServiceModeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceModeInfoScreenController());

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const CustomLargeTitle(title: "معلومات اكثر"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 20),
            const CustomWidgetTitle(title: "الخدمة"),
            SizedBox(
              height: Get.height * 0.14,
              child: ShortServiceTable(service: controller.serviceEntity),
            ),
            const CustomWidgetTitle(title: "ملاحضة"),
            CustomServiceMoreInfoNote(note: controller.serviceEntity.note),
            const CustomWidgetTitle(title: "الشاحنة"),
            CustomServiceMoreInfoTruckInfo(serviceEntity: controller.serviceEntity),
          ],
        ),
      ),
    );
  }
}
