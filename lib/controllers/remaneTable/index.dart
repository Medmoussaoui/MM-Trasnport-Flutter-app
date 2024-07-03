import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmtransport/Data/entitys/table.entity.dart';
import 'package:mmtransport/class/snackbars.dart';
import 'package:mmtransport/controllers/remaneTable/rename_table_controller.dart';

class RenameTableScreenController extends GetxController {
  late TextEditingController tableNameFormController;
  late final Function(TableEntity tableEntity) onRenameSaved;
  late final TableEntity table;

  RxBool onSave = false.obs;

  String get tableName => tableNameFormController.value.text;

  onTapSave() async {
    if (tableName.isEmpty || onSave.value) return;
    onSave.value = true;
    table.tableName = tableName;
    final res = await RenameTableController(table).rename();
    onSave.value = false;
    if (res.isSuccess) {
      successRenameTable();
      onRenameSaved(table);
    }
  }

  void successRenameTable() {
    Get.back();
    AppSnackBars.successRenameTable();
  }

  void initialArgements() {
    onRenameSaved = Get.arguments["onRenameSaved"];
    table = Get.arguments["table"];
  }

  @override
  void onClose() {
    tableNameFormController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    initialArgements();
    tableNameFormController = TextEditingController(text: table.tableName);
    super.onInit();
  }
}
