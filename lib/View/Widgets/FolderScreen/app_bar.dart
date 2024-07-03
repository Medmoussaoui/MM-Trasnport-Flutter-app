import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/custom_large_title.dart';
import 'package:mmtransport/controllers/folders/index.dart';

AppBar customFolderScreenAppBar(FoldersScreenController controller) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black87),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: const CustomLargeTitle(title: "الجداول", size: 16),
    actions: [
      Obx(
        () {
          if (controller.tableIndex.value >= 0) {
            return IconButton(
              splashRadius: 23,
              onPressed: () {
                controller.showTableMenu();
              },
              icon: const Icon(Icons.more_vert_rounded),
            );
          }
          return IconButton(
            splashRadius: 23,
            onPressed: () {
              controller.redirectToCreateTable();
            },
            icon: const Icon(Icons.note_add_outlined),
          );
        },
      )
    ],
  );
}
