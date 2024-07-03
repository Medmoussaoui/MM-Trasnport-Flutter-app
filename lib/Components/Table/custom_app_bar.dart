import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Components/Table/Controller/index.dart';
import 'package:mmtransport/Components/custom_large_title.dart';

class CustomTableDataAppBarSelectMode extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TableDataController controller;
  final PreferredSizeWidget appBar;

  const CustomTableDataAppBarSelectMode({
    Key? key,
    this.title,
    required this.controller,
    required this.appBar,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(59);

  String _appBarTitle() {
    if (title == null) {
      return "تحديد البيانات";
    }
    return title!;
  }

  Widget _selectIcon() {
    return GestureDetector(
      onTap: () {
        controller.selectRowsController.selectAllRows();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 24,
        width: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: controller.selectRowsController.isAllRowsSelected ? Colors.white : Colors.transparent,
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: controller.selectRowsController.isAllRowsSelected
            ? const Icon(
                Icons.done,
                color: Colors.black,
                size: 17,
              )
            : null,
      ),
    );
  }

  Widget _selectCounter() {
    return Obx(() {
      return Row(
        children: [
          _selectIcon(),
          Text(controller.selectRowsController.totalRowsSelect.toString()),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.selectRowsController.selectMode.value) {
          return AppBar(
            leadingWidth: 80,
            elevation: 0.5,
            centerTitle: true,
            title: CustomLargeTitle(
              title: _appBarTitle(),
              color: Colors.white,
            ),
            leading: _selectCounter(),
            actions: [
              IconButton(
                splashRadius: 23,
                onPressed: () {
                  controller.selectRowsController.disableSelectMode();
                },
                icon: const Icon(Icons.close, size: 25),
              ),
              const SizedBox(width: 10),
            ],
          );
        }
        return appBar;
      },
    );
  }
}
