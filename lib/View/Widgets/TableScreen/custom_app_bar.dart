import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/device_connection_state_widget.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/controllers/TableScreen/index.dart';

class CustomtTableScreenAppBar extends GetView<TableScreenController> implements PreferredSizeWidget {
  const CustomtTableScreenAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(59);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        elevation: 0.5,
        //centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 23,
          onPressed: () async {},
          icon: IconButton(
            splashRadius: 23.0,
            onPressed: () {
              controller.showTableMenuSheet();
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ),
        title: ValueListenableBuilder(
          valueListenable: controller.table,
          builder: (_, TableEntity table, child) {
            return CustomLargeTitle(
              title: table.tableName ?? "غير معروف",
              color: Colors.white,
            );
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              controller.tableDataController.fetchRows();
            },
            splashRadius: 23,
            icon: const Icon(Icons.refresh_outlined, size: 25),
          ),
          const SizedBox(width: 10.0),
          const DeviceConnectionStateWidget(),
          const SizedBox(width: 7.0),
          IconButton(
            splashRadius: 23,
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}
