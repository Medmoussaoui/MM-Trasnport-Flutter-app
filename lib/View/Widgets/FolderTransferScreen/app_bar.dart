import 'package:flutter/material.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/Constant/app.color.dart';
import 'package:mmtransport/controllers/TransferScreen/index.dart';

AppBar customFolderTransferScreenAppBar(FoldersTransferScreenController controller) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black87),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: const CustomLargeTitle(title: "نقل العناصر", size: 16),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.layers,
            color: AppColors.secondColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomLargeTitle(title: controller.totalTransfer.toString()),
          ),
        ],
      )
    ],
  );
}
