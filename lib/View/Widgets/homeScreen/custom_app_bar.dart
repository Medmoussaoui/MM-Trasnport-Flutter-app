import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Components/device_connection_state_widget.dart';
import 'package:mmtransport/class/redirect_to.dart';
import 'package:mmtransport/class/user.dart';
import 'package:mmtransport/controllers/HomePage/index.dart';

class CustomHomeScreenAppBar extends GetView<HomePageController> implements PreferredSizeWidget {
  const CustomHomeScreenAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(59);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppBar(
        //leadingWidth: 80,
        elevation: 0.5,
        //centerTitle: true,
        leading: IconButton(
          padding: EdgeInsets.zero,
          splashRadius: 23,
          onPressed: AppUser.user.admin
              ? () async {
                  RedirectTo.folders();
                }
              : null,
          disabledColor: Colors.white54,
          icon: const Icon(Icons.folder, size: 25),
        ),
        title: const FittedBox(
          child: CustomLargeTitle(
            title: "بيانات جديدة",
            color: Colors.white,
          ),
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
          const SizedBox(width: 10),
          const DeviceConnectionStateWidget(),
          const SizedBox(width: 10),
          IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 23,
            icon: const Icon(Icons.menu_rounded),
            onPressed: controller.showMenuBottomSheet,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
